#!/bin/bash

# Function to show usage
show_usage() {
	echo "Usage: $0 [-m \"change description\"]"
	echo "Options:"
	echo "  -m    User-provided change description"
	echo "  -h    Show this help message"
	echo
	echo "Example:"
	echo "  $0 -m \"Add WebSocket support and implement new caching layer\""
	exit 1
}

# Parse command line arguments
while getopts "m:h" opt; do
	case $opt in
	m)
		USER_DESCRIPTION="$OPTARG"
		;;
	h)
		show_usage
		;;
	\?)
		echo "Invalid option: -$OPTARG"
		show_usage
		;;
	esac
done

# Check if we're in a git repository
if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
	echo "Error: Not in a git repository"
	exit 1
fi

# Check if llm is installed
if ! command -v llm &>/dev/null; then
	echo "Error: llm CLI is not installed. Install it using 'pip install llm'"
	exit 1
fi

# Get the latest two tags
LATEST_TAG=$(git tag --sort=-committerdate | sed -n '1p')
PREVIOUS_TAG=$(git tag --sort=-committerdate | sed -n '2p')

if [ -z "$LATEST_TAG" ] || [ -z "$PREVIOUS_TAG" ]; then
	echo "Error: Need at least two tags to generate changelog"
	exit 1
fi

echo "Generating changelog between $PREVIOUS_TAG and $LATEST_TAG"

# Create temporary files
TEMP_COMMITS=$(mktemp)
TEMP_PROMPT=$(mktemp)
TEMP_OUTPUT=$(mktemp)

# Get commit messages between tags
git log "$PREVIOUS_TAG..$LATEST_TAG" --oneline >"$TEMP_COMMITS"

# First part of the prompt template (before commits)
cat >"$TEMP_PROMPT" <<'EOL'
You are a technical writer specializing in writing clear, concise, and technical GitHub release changelogs. Follow these guidelines:

FORMAT RULES:
- Use present tense for new features: "Add", "Introduce", "Implement"
- Use past tense for fixes and changes: "Fixed", "Updated", "Removed"
- Start each entry with a capitalized verb
- Do not use exclamation marks or marketing language
- Omit articles (a, an, the) at the start of entries
- Group changes under relevant categories: Added, Fixed, Changed, Removed, Security, Performance
- Include PR/Issue numbers in parentheses at the end of entries when applicable
- Keep entries under 80 characters when possible
- Use bullet points for all entries

CONTENT GUIDELINES:
- Focus on technical details and implementation specifics
- Include breaking changes first, marked with [BREAKING]
- Mention any database migrations or schema changes
- Note changes to dependencies and version requirements
- Specify any configuration changes
- Include relevant metrics for performance improvements
- Reference deprecation notices and migration guides
- Document API changes with before/after examples
- Highlight security-relevant updates

TONE AND STYLE:
- Be neutral and technical
- Avoid subjective descriptors like "better", "improved", "enhanced"
- Use precise technical terms instead of general descriptions
- Quantify changes when possible (e.g., "Reduced memory usage by 25%")
- Keep focus on what changed, not why it changed
- Omit personal pronouns
- Avoid abbreviations unless widely recognized in technical context

EOL

# Add user-provided description if available
if [ -n "$USER_DESCRIPTION" ]; then
	cat >>"$TEMP_PROMPT" <<EOL

USER-PROVIDED CHANGE DESCRIPTION:
The following description was provided by the development team and should be given priority in the changelog. Incorporate this description while maintaining the formatting guidelines above:

${USER_DESCRIPTION}

EOL
fi

# Add commit messages
cat >>"$TEMP_PROMPT" <<EOL

COMMIT HISTORY:
The following commit messages provide additional context for the changes:

$(cat "$TEMP_COMMITS")

EOL

# Add final instructions with emphasis on user description if provided
if [ -n "$USER_DESCRIPTION" ]; then
	echo -e "\nPlease generate a changelog based on the provided information, giving priority to the user-provided description while using commit messages for additional context and details. Follow the formatting guidelines above." >>"$TEMP_PROMPT"
else
	echo -e "\nPlease generate a changelog based on these commits, following the guidelines above." >>"$TEMP_PROMPT"
fi

# Generate changelog using llm with Claude 3.5 Sonnet
llm -m claude-3.5-sonnet --system "$(cat $TEMP_PROMPT)" "Generate a technical changelog based on the provided information." >"$TEMP_OUTPUT"

# Create release notes directory if it doesn't exist
mkdir -p .changelog

# Save changelog to file
OUTPUT_FILE=".changelog/changelog-${LATEST_TAG}.md"
cat "$TEMP_OUTPUT" >"$OUTPUT_FILE"

echo "Changelog generated and saved to $OUTPUT_FILE"

# Cleanup temporary files
rm "$TEMP_COMMITS" "$TEMP_PROMPT" "$TEMP_OUTPUT"

# Optional: Display the changelog
echo "Generated changelog:"
echo "==================="
cat "$OUTPUT_FILE"

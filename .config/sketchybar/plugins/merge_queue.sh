#!/usr/bin/env bash

# Base API URL
BASE_URL="https://kargo-api.prod.lokalise.cloud"

# Get all projects with merge_queue_enabled == true
projects=$(curl -s "$BASE_URL/project" | jq '.projects | map(select(.merge_queue_enabled == true))')

# If no projects, just set count to 0
if [[ -z "$projects" || "$projects" == "null" ]]; then
  count=0
else
  count=0

  # Loop through each project
  for project in $(echo "$projects" | jq -r '.[] | @base64'); do
    # Decode the project object
    project_name=$(echo "$project" | base64 --decode | jq -r '.name')

    # Check if project name is valid
    if [[ -z "$project_name" || "$project_name" == "null" ]]; then
      continue
    fi

    # Fetch merges for the project
    merges=$(curl -s "$BASE_URL/merge/?owner=lokalise&repo=$project_name" | jq '.merges')

    # Check if merges were fetched correctly
    if [[ -z "$merges" || "$merges" == "null" ]]; then
      continue
    fi

    # Count statuses "merging" or "added"
    status_count=$(echo "$merges" | jq '[.[] | select(.status == "merging" or .status == "added")] | length')
    count=$((count + status_count))
  done
fi

# Choose an icon from Nerd Fonts that represents merges or code forks
# For example:   (nf-fa-code-fork)
ICON=""

# Set label color depending on count
if [[ "$count" -gt 0 ]]; then
  LABEL_COLOR="0xffa6e3a1"
else
  LABEL_COLOR="0xffffffff"
fi

# Update the SketchyBar item
sketchybar --set "$NAME" icon="$ICON" label="$count" label.color="$LABEL_COLOR" icon.color="$LABEL_COLOR" click_script="open https://kargo.prod.lokalise.cloud/merge-queue"

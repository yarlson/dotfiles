#!/usr/bin/env bash
set -o pipefail

source "$CONFIG_DIR/colors.sh"
source "$CONFIG_DIR/icons.sh"

BASE_URL="https://kargo-api.prod.lokalise.cloud"

projects=$(curl -sf --max-time 10 "$BASE_URL/project" | jq -e '.projects | map(select(.merge_queue_enabled == true))' 2>/dev/null)

if [[ $? -ne 0 || -z "$projects" || "$projects" == "null" ]]; then
  count=0
else
  count=0

  for project in $(echo "$projects" | jq -r '.[] | @base64'); do
    project_name=$(echo "$project" | base64 --decode | jq -r '.name')

    if [[ -z "$project_name" || "$project_name" == "null" ]]; then
      continue
    fi

    merges=$(curl -sf --max-time 10 "$BASE_URL/merge/?owner=lokalise&repo=$project_name" | jq -e '.merges' 2>/dev/null)

    if [[ $? -ne 0 || -z "$merges" || "$merges" == "null" ]]; then
      continue
    fi

    status_count=$(echo "$merges" | jq '[.[] | select(.status == "merging" or .status == "added")] | length')
    count=$((count + status_count))
  done
fi

if [[ "$count" -gt 0 ]]; then
  LABEL_COLOR="$COLOR_GREEN"
else
  LABEL_COLOR="$COLOR_WHITE"
fi

sketchybar --set "$NAME" \
  icon="$ICON_MERGE" \
  label="$count" \
  label.color="$LABEL_COLOR" \
  icon.color="$LABEL_COLOR" \
  click_script="open https://kargo.prod.lokalise.cloud/merge-queue"

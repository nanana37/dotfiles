#!/bin/bash
set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
AEROSPACE_DIR="$SCRIPT_DIR/../packages/aerospace/.config/aerospace"

TEMPLATE="$AEROSPACE_DIR/aerospace.toml.template"
LOCAL="$AEROSPACE_DIR/aerospace-local.toml"
OUTPUT="$AEROSPACE_DIR/aerospace.toml"

echo "Generating AeroSpace config..."

# Start with the template
cat "$TEMPLATE" > "$OUTPUT"

# Append local config if it exists
if [ -f "$LOCAL" ]; then
    echo "Merging $LOCAL..."
    echo -e "\n# --- Local Config ---" >> "$OUTPUT"
    cat "$LOCAL" >> "$OUTPUT"
else
    echo "No local config found at $LOCAL (skipping merge)"
fi

echo "Done! Generated $OUTPUT"

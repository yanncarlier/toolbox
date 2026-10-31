#!/usr/bin/env bash
# rename_case.sh
# Summary: Rename a case by converting its name to uppercase.
# Usage: bash rename_case.sh <file>

set -euo pipefail

if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <file>"
    exit 1
fi

current_file="$1"
# new_file=$(echo "$current_file" | tr '[:lower:]' '[:upper:]')
new_file=$(echo "$current_file" | tr '[:upper:]' '[:lower:]')

# Perform rename
mv "$current_file" "$new_file"
echo "File name changed to $new_file"


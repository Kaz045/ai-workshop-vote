#!/usr/bin/env bash
set -euo pipefail

# Detect commits that introduced Google API key-like strings.
# This prints commit metadata only (not key values).
pattern='AIza[0-9A-Za-z_-]{20,}'

files=("index.html" "html_experiment/index.html")
if [ "$#" -gt 0 ]; then
  files=("$@")
fi

echo "Scanning commit history for API key-like patterns..."
git log --all --pretty=format:'%h %ad %s' --date=short -G "${pattern}" -- "${files[@]}"

echo
echo "Tip: Use the commit hashes above as targets when cleaning history."

#!/bin/bash
# Usage: parse-packages.sh [solution-dir]
#
# Parses "dotnet list package" console output into JSON.
# Resolves project names to absolute .csproj paths using "dotnet sln list".
# Bridges SDK 6 console output to match the shape of SDK 8+ --format json (post-jq).

set -euo pipefail

sln_dir="$(cd "${1:-.}" && pwd)"
script_dir="$(cd "$(dirname "$0")" && pwd)"

# Build project map: stem=absolute_path
mapfile=$(mktemp)
trap 'rm -f "$mapfile"' EXIT

dotnet sln "$sln_dir" list | tail -n +3 | while read -r csproj; do
    [ -z "$csproj" ] && continue
    stem=$(basename "$csproj" .csproj)
    echo "$stem=$sln_dir/$csproj"
done > "$mapfile"

# Parse package listing, resolving project names via the map
dotnet list "$sln_dir" package | awk -f "$script_dir/parse-packages.awk" "$mapfile" -

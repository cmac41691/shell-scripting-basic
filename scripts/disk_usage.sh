#!/bin/bash
# disk_usage.sh
# Shows disk usage for a given directory or the whole system

# If the user provided a directory, use it; otherwise, check the whole filesystem
TARGET_DIR=${1:-/}

echo "Checking disk usage for: $TARGET_DIR"
echo "----------------------------------"

# -h for human-readable sizes, -s for summary
du -sh "$TARGET_DIR" 2>/dev/null

echo
echo "Top 5 largest subdirectories/files:"
du -ah "$TARGET_DIR" 2>/dev/null | sort -rh | head -n 5

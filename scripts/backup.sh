#!/bin/bash
# backup.sh - Simple script to back up a file with timestamp

echo "Enter the filename to back up"
read source_file

if [ -f "$source_file" ]; then
    timestamp=$(date +"%Y%m%d_%H%M%S")
    backup_file="${source_file}_backup_$timestamp"
    cp "$source_file" "$backup_file"
    echo "Backup created: $backup_file"
else
    echo "File does not exist!"
    exit 1
fi


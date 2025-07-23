#!/bin/bash
# backup-dir.sh - Back up a directory with a timestamp

echo "Enter the name of the directory to back up:"
read sourcedir

# Check if the directory exists
if [ ! -d "$sourcedir" ]; then
  echo "❌ Error: Directory '$sourcedir' does not exist."
  exit 1
fi

# Create a timestamp
timestamp=$(date +"%Y-%m-%d_%H-%M-%S")

# Set the name of the backup directory
backupdir="backup_${timestamp}"

# Make the backup directory and copy contents
mkdir "$backupdir"
cp -r "$sourcedir"/* "$backupdir"

echo "✅ Backup complete: '$sourcedir' was copied to '$backupdir'"


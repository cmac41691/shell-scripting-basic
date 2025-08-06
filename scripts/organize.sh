#!/bin/bash
# organize.sh - Sort files into folders by extension

echo "Enter the directory to organize:"
read target_dir

cd "$target_dir" || { echo "Directory not found!"; exit 1; }

for file in *.*; do
  # Skip if not a regular file
  [ -f "$file" ] || continue

  ext="${file##*.}"
  mkdir -p "$ext"
  mv "$file" "$ext/"
done

echo "Files organized by extension!"




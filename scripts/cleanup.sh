#!/bin/bash
# cleanup.sh — safely remove old backup folders/files

set -euo pipefail

DRY_RUN=false
if [[ "${1-}" == "--dry-run" ]]; then
  DRY_RUN=true
fi

read -p "Enter the number of days to KEEP (older will be considered for deletion): " days
[[ "$days" =~ ^[0-9]+$ ]] || { echo "Please enter a whole number."; exit 1; }

echo
echo "Searching for items with 'backup' in the name older than $days days..."
echo "(Starting in: $(pwd))"
echo

# Preview list
matches=()
while IFS= read -r -d '' p; do
  matches+=("$p")
done < <(find . \( -type d -o -type f \) -iname "*backup*" -mtime +"$days" -print0)

if (( ${#matches[@]} == 0 )); then
  echo "No old backups found. You're all clean. ✅"
  exit 0
fi

printf "Found %d item(s):\n" "${#matches[@]}"
for p in "${matches[@]}"; do
  echo "  $p"
done
echo

if $DRY_RUN; then
  echo "Dry run only — nothing deleted. (Run without --dry-run to act.)"
  exit 0
fi

read -p "Proceed to review and delete these items one by one? (y/N) " ans
[[ "$ans" =~ ^[Yy]$ ]] || { echo "Aborting. Nothing deleted."; exit 0; }

echo
for p in "${matches[@]}"; do
  read -p "Delete '$p'? (y/N) " d
  if [[ "$d" =~ ^[Yy]$ ]]; then
    # Use rm -r for dirs, rm for files
    if [[ -d "$p" ]]; then
      rm -r -- "$p"
    else
      rm -- "$p"
    fi
    echo "  Deleted: $p"
  else
    echo "  Skipped: $p"
  fi
done

echo
echo "Cleanup complete. ✅"

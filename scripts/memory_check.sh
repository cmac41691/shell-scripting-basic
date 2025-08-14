
#!/bin/bash

# Threshold for memory usage warning
THRESHOLD=80

# Get memory usage (Linux/Unix command; will adapt for Git Bash)
USED=$(free | awk '/Mem/ {print $3}')
TOTAL=$(free | awk '/Mem/ {print $2}')
PERCENT=$(( USED * 100 / TOTAL ))

echo "Memory Usage: $PERCENT%"

if [ "$PERCENT" -gt "$THRESHOLD" ]; then
    echo "WARNING: Memory usage above ${THRESHOLD}%!"
else
    echo "Memory usage is normal."
fi


#!/bin/bash
#logger.sh - Appends user input to activity.log with timestamps

log_file="activity.log"

echo "What Would you like to log?"
read message

timestamp=$(date "+%Y-%m-%d %H:%M:%S")

echo "[$timestamp] $message" >> "$log_file"

echo "Entry logged to $log_file"

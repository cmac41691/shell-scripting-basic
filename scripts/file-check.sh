#!/bin/bash
#file-check.sh - Checks if a file exists

echo "Enter a filename to check:"

read filename

if [ -f "$filename" ]; then
	echo " File '$filename' exists!"
	
else
	echo " File '$filename' does not exist."
fi

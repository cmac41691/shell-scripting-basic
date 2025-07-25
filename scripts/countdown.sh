#!/bin/bash
# countdown.sh - A simple countdown timer

echo "Enter countdown time in seconds:"
read seconds

for (( i=seconds; i>0; i--))

do

 echo -ne "$i...\r"
 sleep 1

done

echo "Time's up!" 

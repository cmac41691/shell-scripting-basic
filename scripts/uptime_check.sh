#!/bin/bash
# uptime_check.sh — cross-platform (Linux/macOS/WSL/Windows Git Bash)

set -euo pipefail

watch_mode=false
interval=5
if [[ "${1-}" == "--watch" ]]; then
  watch_mode=true
  interval="${2-5}"
  [[ "$interval" =~ ^[0-9]+$ ]] || interval=5
fi

has() { command -v "$1" >/dev/null 2>&1; }

get_uptime_pretty() {
  if has uptime; then
    # Linux/macOS/WSL
    if uptime -p >/dev/null 2>&1; then
      uptime -p | sed 's/^up //'
    else
      uptime | sed 's/.*up \([^,]*\), .*/\1/'
    fi
    return
  fi

  # Windows Git Bash fallbacks via PowerShell
  if has powershell.exe; then
    powershell.exe -NoProfile -Command \
      "(Get-Date) - (Get-CimInstance Win32_OperatingSystem).LastBootUpTime | \
       ForEach-Object { '{0}d {1}h {2}m {3}s' -f $_.Days,$_.Hours,$_.Minutes,$_.Seconds }" \
      | tr -d '\r'
    return
  fi

  echo "N/A"
}

get_load_or_cpu() {
  # On Unix, show load averages; on Windows show current CPU usage
  if [[ -f /proc/loadavg ]]; then
    awk '{print $1", "$2", "$3}' /proc/loadavg
  elif has powershell.exe; then
    powershell.exe -NoProfile -Command \
      "(Get-Counter '\Processor(_Total)\% Processor Time' -SampleInterval 1 -MaxSamples 1).CounterSamples.CookedValue | \
       ForEach-Object { '{0:N1}% CPU' -f $_ }" | tr -d '\r'
  else
    echo "N/A"
  fi
}

get_user_count() {
  if has who; then
    # *nix or WSL
    who 2>/dev/null | wc -l | tr -d ' '
  elif has query; then
    # Windows
    # subtract header line if present
    n=$( (query user 2>NUL || echo) | sed '1{/USERNAME/d};/^$/d' | wc -l )
    echo "${n// /}"
  else
    echo "0"
  fi
}

report() {
  now=$(date +"%Y-%m-%d %H:%M:%S")
  up_pretty=$(get_uptime_pretty)
  load_or_cpu=$(get_load_or_cpu)
  users=$(get_user_count)

  clear
  echo "System Uptime Report ($now)"
  echo "------------------------------------------"
  echo "Uptime:          $up_pretty"
  echo "Load / CPU:      $load_or_cpu"
  echo "Logged-in Users: ${users:-0}"
}

if $watch_mode; then
  while true; do
    report
    echo
    echo "(Refreshing every ${interval}s — Ctrl+C to quit)"
    sleep "$interval"
  done
else
  report
fi


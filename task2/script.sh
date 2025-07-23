#!/bin/bash

# Log file path
LOG_FILE="system_health.log"

# Get current timestamp
TIMESTAMP=$(date +"%Y-%m-%d %H:%M:%S")

# Get CPU usage (user + system %)
CPU_USAGE=$(top -bn1 | grep "Cpu(s)" | awk '{print 100 - $8}')
CPU_USAGE_INT=${CPU_USAGE%.*}

# Get memory usage info
MEM_TOTAL=$(free -m | awk '/Mem:/ {print $2}')
MEM_AVAILABLE=$(free -m | awk '/Mem:/ {print $7}')
MEM_AVAILABLE_PERCENT=$(( 100 * MEM_AVAILABLE / MEM_TOTAL ))

# Start logging
echo "[$TIMESTAMP] CPU: ${CPU_USAGE}% | Available Memory: ${MEM_AVAILABLE_PERCENT}%" >> "$LOG_FILE"

# Check thresholds
if [ "$CPU_USAGE_INT" -gt 80 ]; then
    echo "[$TIMESTAMP] WARNING: CPU usage is above 80%" >> "$LOG_FILE"
fi

if [ "$MEM_AVAILABLE_PERCENT" -lt 20 ]; then
    echo "[$TIMESTAMP] WARNING: Available memory is below 20%" >> "$LOG_FILE"
fi

echo "Check complete and logged to $LOG_FILE"


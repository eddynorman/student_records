#!/bin/bash

LOG_FILE="/var/log/server_health.log"
TIMESTAMP=$(date "+%Y-%m-%d %H:%M:%S")

echo "[$TIMESTAMP] Starting health check..." >> $LOG_FILE

# CPU USAGE CHECK
CPU_USAGE=$(top -bn1 | grep "Cpu(s)" | awk '{print 100 - $8}')
if (( $(echo "$CPU_USAGE > 85.0" | bc -l) )); then
    echo "[$TIMESTAMP] WARNING: High CPU Usage - ${CPU_USAGE}% used." >> $LOG_FILE
else
    echo "[$TIMESTAMP] CPU Usage OK - ${CPU_USAGE}% used." >> $LOG_FILE
fi

# MEMORY USAGE CHECK
MEMORY_USAGE=$(free | grep Mem | awk '{printf("%.2f"), $3/$2 * 100.0}')
if (( $(echo "$MEMORY_USAGE > 85.0" | bc -l) )); then
    echo "[$TIMESTAMP] WARNING: High Memory Usage - ${MEMORY_USAGE}% used." >> $LOG_FILE
else
    echo "[$TIMESTAMP] Memory Usage OK - ${MEMORY_USAGE}% used." >> $LOG_FILE
fi

# DISK USAGE CHECK
DISK_USAGE=$(df / | grep / | awk '{print $5}' | sed 's/%//')
if [ "$DISK_USAGE" -ge 90 ]; then
    echo "[$TIMESTAMP] WARNING: High Disk Usage - ${DISK_USAGE}% used." >> $LOG_FILE
else
    echo "[$TIMESTAMP] Disk Usage OK - ${DISK_USAGE}% used." >> $LOG_FILE
fi

# WEB SERVER STATUS CHECK (assumes nginx)
if systemctl is-active --quiet nginx; then
    echo "[$TIMESTAMP] Nginx is running." >> $LOG_FILE
else
    echo "[$TIMESTAMP] WARNING: Nginx is NOT running." >> $LOG_FILE
fi

# API ENDPOINT CHECKS
API_BASE="http://51.20.2.101/api" # Replace with your API base URL

for endpoint in "students" "subjects"
do
    HTTP_STATUS=$(curl -s -o /dev/null -w "%{http_code}" $API_BASE/$endpoint/)
    if [ "$HTTP_STATUS" -ne 200 ]; then
        echo "[$TIMESTAMP] WARNING: API endpoint /$endpoint returned status $HTTP_STATUS." >> $LOG_FILE
    else
        echo "[$TIMESTAMP] API endpoint /$endpoint OK (200)." >> $LOG_FILE
    fi
done

echo "[$TIMESTAMP] Health check complete." >> $LOG_FILE
echo "--------------------------------------------------" >> $LOG_FILE

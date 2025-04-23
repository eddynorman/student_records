#!/bin/bash

TIMESTAMP=$(date "+%Y-%m-%d %H:%M:%S")
LOG_FILE="/var/log/update.log"
PROJECT_DIR="/home/ubuntu/student_records"

echo "[$TIMESTAMP] Starting update..." >> $LOG_FILE

# Update system packages
if apt update && apt upgrade -y; then
    echo "[$TIMESTAMP] System packages updated successfully." >> $LOG_FILE
else
    echo "[$TIMESTAMP] WARNING: Failed to update system packages." >> $LOG_FILE
fi

# Pull latest code from GitHub
cd $PROJECT_DIR
if git pull origin main; then
    echo "[$TIMESTAMP] Code pulled from GitHub successfully." >> $LOG_FILE
else
    echo "[$TIMESTAMP] ERROR: Git pull failed. Aborting update." >> $LOG_FILE
    echo "--------------------------------------------------" >> $LOG_FILE
    exit 1
fi

# Restart Gunicorn
if systemctl restart gunicorn; then
    echo "[$TIMESTAMP] Gunicorn restarted successfully." >> $LOG_FILE
else
    echo "[$TIMESTAMP] WARNING: Failed to restart Gunicorn." >> $LOG_FILE
fi

# Restart Nginx
if systemctl restart nginx; then
    echo "[$TIMESTAMP] Nginx restarted successfully." >> $LOG_FILE
else
    echo "[$TIMESTAMP] WARNING: Failed to restart Nginx." >> $LOG_FILE
fi

echo "[$TIMESTAMP] Update process completed." >> $LOG_FILE
echo "--------------------------------------------------" >> $LOG_FILE

#!/bin/bash

TIMESTAMP=$(date +%F)
BACKUP_DIR="/home/ubuntu/backups"
LOG_FILE="/var/log/backup.log"
PROJECT_DIR="/home/ubuntu/student_records"
API_BACKUP="$BACKUP_DIR/api_backup_$TIMESTAMP.tar.gz"
DB_BACKUP="$BACKUP_DIR/db_backup_$TIMESTAMP.sql"

mkdir -p $BACKUP_DIR

echo "[$(date "+%Y-%m-%d %H:%M:%S")] Starting backup..." >> $LOG_FILE

# Backup API files
if tar -czf $API_BACKUP $PROJECT_DIR 2>/dev/null; then
    echo "[$(date "+%Y-%m-%d %H:%M:%S")] API files backed up to $API_BACKUP" >> $LOG_FILE
else
    echo "[$(date "+%Y-%m-%d %H:%M:%S")] WARNING: Failed to back up API files." >> $LOG_FILE
fi


if mysqldump -u django_user -p'Emperor666*' student_db > $DB_BACKUP 2>/dev/null; then

echo "[$(date "+%Y-%m-%d %H:%M:%S")] Database backed up to $DB_BACKUP" >> $LOG_FILE
else
    echo "[$(date "+%Y-%m-%d %H:%M:%S")] WARNING: Failed to back up database." >> $LOG_FILE
fi

# Cleanup backups older than 7 days
find $BACKUP_DIR -type f -mtime +7 -exec rm {} \;
echo "[$(date "+%Y-%m-%d %H:%M:%S")] Old backups cleaned up (older than 7 days)." >> $LOG_FILE
echo "[$(date "+%Y-%m-%d %H:%M:%S")] Backup process completed." >> $LOG_FILE
echo "--------------------------------------------------" >> $LOG_FILE

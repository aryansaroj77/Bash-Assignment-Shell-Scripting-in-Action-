#!/bin/bash

# Folder where backups will be stored
BACKUP_DIR="/mnt/d/AWS_DSA/bashPratices/Bashassigment/task4"

# Get directory from user input
read -p "Enter the full path of the directory to back up: " SOURCE_DIR

# Validate input
if [ ! -d "$SOURCE_DIR" ]; then
  echo "❌ Error: '$SOURCE_DIR' is not a valid directory."
  exit 1
fi

# Get current date
DATE=$(date +"%Y-%m-%d")

# Extract the folder name from the source path
FOLDER_NAME=$(basename "$SOURCE_DIR")

# Create backup filename
BACKUP_FILE="backup_${FOLDER_NAME}_$DATE.tar.gz"

# Create the backup
tar -czf "$BACKUP_DIR/$BACKUP_FILE" -C "$(dirname "$SOURCE_DIR")" "$FOLDER_NAME"

# Confirm success
if [ $? -eq 0 ]; then
  echo "✅ Backup successful!"
  echo "📁 File saved at: $BACKUP_DIR/$BACKUP_FILE"
else
  echo "❌ Backup failed."
fi


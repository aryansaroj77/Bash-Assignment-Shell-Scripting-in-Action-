#!/bin/bash

# Set source and destination directories
SOURCE_DIR="/mnt/d/AWS_DSA/bashPratices/Bashassigment/task1/workfile"
DEST_DIR="/mnt/d/AWS_DSA/bashPratices/Bashassigment/task1/backup"

# Get current timestamp
TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")

# Loop through all .txt files in the source directory
for file in "$SOURCE_DIR"/*.txt; do
  if [ -f "$file" ]; then
    # Get the base filename (without path)
    filename=$(basename "$file")
    # Remove the .txt extension
    name="${filename%.txt}"
    # Create the new filename with timestamp
    new_name="${name}_$TIMESTAMP.txt"
    # Copy the file to the destination with new name
    cp "$file" "$DEST_DIR/$new_name"
  fi
done

echo "All .txt files moved to backup with timestamp."



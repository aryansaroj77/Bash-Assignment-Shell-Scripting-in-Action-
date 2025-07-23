#!/bin/bash

# Prompt user for input file
read -p "Enter the path to the text file: " FILE

# Check if the file exists
if [ ! -f "$FILE" ]; then
  echo "❌ File not found: $FILE"
  exit 1
fi

# Count lines, words, and characters
LINES=$(wc -l < "$FILE")
WORDS=$(wc -w < "$FILE")
CHARS=$(wc -m < "$FILE")

# Find the longest word
LONGEST_WORD=$(tr -cs '[:alnum:]' '[\n*]' < "$FILE" | awk '{ if (length > max) { max = length; word = $0 } } END { print word }')

# Display the results
echo "📄 File: $FILE"
echo "📏 Lines       : $LINES"
echo "🔤 Words       : $WORDS"
echo "🔡 Characters  : $CHARS"
echo "🏆 Longest word: $LONGEST_WORD"


#!/bin/bash

# Files
USER_FILE="user_list.txt"
CREDENTIALS_FILE="credentials.txt"

# Empty the credentials file if it exists
> "$CREDENTIALS_FILE"

# Check if user_list.txt exists
if [ ! -f "$USER_FILE" ]; then
  echo "ERROR: $USER_FILE not found!"
  exit 1
fi

# Read usernames and create users
while IFS= read -r username || [ -n "$username" ]; do
  # Skip empty lines
  [ -z "$username" ] && continue

  # Check if user already exists
  if id "$username" &>/dev/null; then
    echo "User '$username' already exists. Skipping..."
    continue
  fi

  # Generate a random 12-character password
  password=$(openssl rand -base64 12)

  # Create the user with a home directory
  useradd -m "$username"

  # Set the password
  echo "$username:$password" | chpasswd

  # Save credentials
  echo "$username:$password" >> "$CREDENTIALS_FILE"

  echo "✅ Created user: $username"
done < "$USER_FILE"

echo "🎉 All users processed. Credentials saved in '$CREDENTIALS_FILE'."


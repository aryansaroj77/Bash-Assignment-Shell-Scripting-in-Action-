#!/bin/bash

PACKAGE_FILE="packages.txt"
LOG_FILE="install_log.txt"

# Detect package manager
if command -v apt &>/dev/null; then
  PKG_MANAGER="apt"
  INSTALL_CMD="sudo apt install -y"
elif command -v yum &>/dev/null; then
  PKG_MANAGER="yum"
  INSTALL_CMD="sudo yum install -y"
else
  echo "❌ No supported package manager found (apt or yum)." | tee -a "$LOG_FILE"
  exit 1
fi

# Make sure the package list file exists
if [ ! -f "$PACKAGE_FILE" ]; then
  echo "❌ Package list file '$PACKAGE_FILE' not found."
  exit 1
fi

# Clear previous log
> "$LOG_FILE"

echo "📦 Installing packages using $PKG_MANAGER..."
echo "==== Installation Log: $(date) ====" >> "$LOG_FILE"

# Read each package from the list
while IFS= read -r package || [ -n "$package" ]; do
  [ -z "$package" ] && continue

  echo -n "Installing $package... "
  if $INSTALL_CMD "$package" &>> "$LOG_FILE"; then
    echo "✅ Success" | tee -a "$LOG_FILE"
  else
    echo "❌ Failed to install $package" | tee -a "$LOG_FILE"
  fi
done < "$PACKAGE_FILE"

echo "📄 Installation log saved to $LOG_FILE"


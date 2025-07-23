#!/bin/bash

TODO_FILE="todo.txt"

# Make sure the file exists
touch "$TODO_FILE"

# Show menu
while true; do
  echo ""
  echo "====== SIMPLE TO-DO LIST ======"
  echo "1. View Tasks"
  echo "2. Add Task"
  echo "3. Remove Task"
  echo "4. Exit"
  echo "==============================="
  read -p "Enter your choice [1-4]: " choice

  case "$choice" in
    1)
      echo ""
      echo "📋 Your To-Do List:"
      if [ -s "$TODO_FILE" ]; then
        nl -w2 -s'. ' "$TODO_FILE"
      else
        echo "No tasks found."
      fi
      ;;
    2)
      read -p "📝 Enter the task: " task
      echo "$task" >> "$TODO_FILE"
      echo "✅ Task added."
      ;;
    3)
      echo "📋 Current tasks:"
      nl -w2 -s'. ' "$TODO_FILE"
      read -p "❌ Enter task number to remove: " number
      if [[ "$number" =~ ^[0-9]+$ ]]; then
        sed -i "${number}d" "$TODO_FILE"
        echo "🗑️ Task $number removed."
      else
        echo "❌ Invalid input."
      fi
      ;;
    4)
      echo "👋 Exiting To-Do List. Goodbye!"
      break
      ;;
    *)
      echo "❌ Invalid choice. Please enter 1-4."
      ;;
  esac
done


#!/bin/bash
# Shell Script for Monitoring Memory Usage
# Usage: ./memory_monitor.sh

# Function to display memory usage with timestamp
display_memory_usage() {
  timestamp=$(date "+%Y-%m-%d %H:%M:%S")  # Get current timestamp
  echo "[$timestamp] Current Memory Usage:"
  free -h
  echo ""
}

# Function to display memory usage in real-time with timestamp
monitor_memory_usage() {
  echo "Monitoring memory usage in real-time. Press [CTRL+C] to stop."
  # Use top command to show memory usage updates every 2 seconds with timestamp
  while true; do
    timestamp=$(date "+%Y-%m-%d %H:%M:%S")  # Get current timestamp
    echo "[$timestamp] Memory Usage:"
    free -h
    sleep 2  # Wait 2 seconds before updating
  done
}

# Displaying options to the user
echo "Dynamic Memory Monitor"
echo "1. Display current memory usage"
echo "2. Monitor memory usage in real-time"
echo "3. Exit"

# Loop until the user chooses to exit
while true; do
  read -p "Select an option (1-3): " option
  case $option in
    1) # Display current memory usage
      display_memory_usage
      ;;
    2) # Monitor memory usage in real-time
      monitor_memory_usage
      ;;
    3) # Exit the script
      echo "Exiting the memory monitor. Goodbye!"
      exit 0
      ;;
    *) # Invalid option
      echo "Invalid option. Please select 1-3."
      ;;
  esac
  echo "" # Print a newline for better readability
done

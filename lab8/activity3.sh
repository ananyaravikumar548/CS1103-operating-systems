
#include time stamps of each entry
#Extend the script to send an alert email if available memory give warning
#!/bin/bash
# Shell Script for Monitoring Memory Usage with Logging and Email Alerts
# Usage: ./memory_monitor.sh
# Function to display memory usage
display_memory_usage() {
    echo "Current Memory Usage:"
    free -h
    echo ""
}

# Function to log memory usage every 10 seconds with a timestamp
log_memory_usage() {
    while true; do
        # Get current timestamp
        timestamp=$(date "+%Y-%m-%d %H:%M:%S")
       
        # Log memory usage with timestamp
        memory_usage=$(free -h | grep Mem | awk '{print $3 " / " $2 " used, " $4 " free"}')
        echo "$timestamp - $memory_usage" >> memory_log.txt
       
        # Print log message to console
        echo "$timestamp - $memory_usage"

        # Sleep for 10 seconds
        sleep 10
    done
}

# Function to send an alert email if available memory is below threshold
send_alert_email() {
    # Set the memory threshold in MB (e.g., 500MB)
    THRESHOLD=500
   
    # Get available memory in MB
    available_memory=$(free -m | grep Mem | awk '{print $4}')
   
    # Check if available memory is below threshold
    if [ "$available_memory" -lt "$THRESHOLD" ]; then
        # Send email alert (requires mail or sendmail to be configured)
        echo "Warning: Available memory is below threshold ($THRESHOLD MB). Current available memory: $available_memory MB" | mail -s "Memory Usage Warning" your_email@example.com
    fi
}

# Function to display memory usage in real-time
monitor_memory_usage() {
    echo "Monitoring memory usage in real-time. Press [CTRL+C] to stop."
    # Use top command to show memory usage updates every 2 seconds
    top -o %MEM
}

# Displaying options to the user
echo "Dynamic Memory Monitor"
echo "1. Display current memory usage"
echo "2. Monitor memory usage in real-time"
echo "3. Log memory usage every 10 seconds"
echo "4. Exit"

# Loop until the user chooses to exit
while true; do
    read -p "Select an option (1-4): " option
    case $option in
        1) # Display current memory usage
            display_memory_usage
            ;;
        2) # Monitor memory usage in real-time
            monitor_memory_usage
            ;;
        3) # Log memory usage every 10 seconds
            echo "Logging memory usage every 10 seconds..."
            log_memory_usage &
            ;;
        4) # Exit the script
            echo "Exiting the memory monitor. Goodbye!"
            exit 0
            ;;
        *) # Invalid option
            echo "Invalid option. Please select 1-4."
            ;;
    esac
    echo "" # Print a newline for better readability
   
    # Check memory and send email alert if needed
    send_alert_email
done

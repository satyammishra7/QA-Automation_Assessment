#!/bin/bash

# Configuration
URL="https://www.google.com/"  # URL to check
EXPECTED_STATUS_CODE=200                        # Expected HTTP status code for a healthy application
LOG_FILE="/var/log/application_uptime.log"      # Log file location
DATE=$(date '+%Y-%m-%d %H:%M:%S')               # Date format for log

# Function to log messages
log_message() {
    echo "$DATE - $1" >> $LOG_FILE
}

# Function to check application status
check_application() {
    HTTP_STATUS=$(curl -o /dev/null -s -w "%{http_code}\n" "$URL")

    if [ "$HTTP_STATUS" -eq "$EXPECTED_STATUS_CODE" ]; then
        log_message "UP: Application is functioning correctly. Status code: $HTTP_STATUS"
        echo "UP"
    else
        log_message "DOWN: Application is unavailable or not responding. Status code: $HTTP_STATUS"
        echo "DOWN"
    fi
}

# Main script execution
log_message "Checking application uptime at $URL"
APPLICATION_STATUS=$(check_application)

# Optional: Notify user via console
echo "Application status: $APPLICATION_STATUS"
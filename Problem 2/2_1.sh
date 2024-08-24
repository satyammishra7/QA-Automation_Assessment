#!/bin/bash

# Log file location
LOG_FILE="/var/log/system_health.log"

# Thresholds
CPU_THRESHOLD=10
MEMORY_THRESHOLD=10
DISK_THRESHOLD=10
PROCESS_THRESHOLD=1

# Function to log message
log_message() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $1" >> $LOG_FILE
}

# Check CPU usage
check_cpu_usage() {
    CPU_USAGE=$(top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print 100 - $1}')
    if (( $(echo "$CPU_USAGE > $CPU_THRESHOLD" | bc -l) )); then
        log_message "WARNING: High CPU usage detected: ${CPU_USAGE}%"
    fi
}

# Check memory usage
check_memory_usage() {
    MEMORY_USAGE=$(free | grep Mem | awk '{print $3/$2 * 100.0}')
    if (( $(echo "$MEMORY_USAGE > $MEMORY_THRESHOLD" | bc -l) )); then
        log_message "WARNING: High Memory usage detected: ${MEMORY_USAGE}%"
    fi
}

# Check disk usage
check_disk_usage() {
    DISK_USAGE=$(df / | grep / | awk '{ print $5 }' | sed 's/%//g')
    if [ "$DISK_USAGE" -gt "$DISK_THRESHOLD" ]; then
        log_message "WARNING: High Disk usage detected: ${DISK_USAGE}%"
    fi
}

# Check running processes
check_running_processes() {
    PROCESS_COUNT=$(ps aux | wc -l)
    if [ "$PROCESS_COUNT" -gt "$PROCESS_THRESHOLD" ]; then
        log_message "WARNING: High number of running processes detected: ${PROCESS_COUNT}"
    fi
}

# Log system health
log_health_status() {
    check_cpu_usage
    check_memory_usage
    check_disk_usage
    check_running_processes
    log_message "System health check completed."
}

# Main loop
while true; do
    log_health_status
    sleep 60  # Check every 60 seconds
done
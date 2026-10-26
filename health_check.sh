#!/bin/bash

# ==========================================================
# Script: health_check.sh
# Description: Service Health Check & Auto-Recovery Script
# Note: Requires root privileges (sudo) to manage systemd services
# ==========================================================

# Check if script is run as root
if [ "$EUID" -ne 0 ]; then
  echo "[ERROR] Please run this script with sudo or as root."
  exit 1
fi

LOG_FILE="/var/log/service_health.log"
DATETIME=$(date "+%Y-%m-%d %H:%M:%S")

# List of critical services to monitor
SERVICES=("cron" "ufw" )

for SERVICE in "${SERVICES[@]}"; do
    # Check if service is active
    if systemctl is-active --quiet "$SERVICE"; then
        echo "[$DATETIME] [OK] Service '$SERVICE' is running normally." >> "$LOG_FILE"
    else
        echo "[$DATETIME] [CRITICAL ALERT] Service '$SERVICE' is DOWN! Attempting to restart..." >> "$LOG_FILE"
        
        # Try to restart the service automatically
        systemctl restart "$SERVICE"
        
        # Verify if restart was successful
        if systemctl is-active --quiet "$SERVICE"; then
            echo "[$DATETIME] [RECOVERY] Service '$SERVICE' was successfully restarted." >> "$LOG_FILE"
        else
            echo "[$DATETIME] [CRITICAL FAILURE] Failed to restart service '$SERVICE'!" >> "$LOG_FILE"
        fi
    fi
done

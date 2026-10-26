# Linux Service Health Check & Auto-Recovery

Automated infrastructure reliability tool built in **Bash Shell** to monitor critical system services, log status updates, and perform automated self-healing (auto-restart) actions upon failure.

## 🚀 Features

- **Service Status Auditing:** Dynamically checks if critical systemd services (e.g., `cron`, `ufw`) are active using `systemctl`.
- **Self-Healing Automation:** Automatically triggers a restart sequence (`systemctl restart`) if a service goes down.
- **Post-Recovery Verification:** Confirms whether the restart attempt was successful and logs the outcome.
- **Comprehensive Logging:** Appends timestamped audit trails (`[OK]`, `[CRITICAL ALERT]`, `[RECOVERY]`, `[CRITICAL FAILURE]`) to `/var/log/service_health.log`.

## 🛠️ Technologies Used

- **Linux (Ubuntu)**
- **Bash Shell Scripting**
- **Systemd Service Management (`systemctl`)**
- **Cron Service (Automation)**

## 💻 How to Run

1. Make the script executable:
   ```bash
   chmod +x health_check.sh


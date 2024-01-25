#!/bin/bash

# Path to the installation log file
log_file="/var/log/install.log"

# Email configuration
recipient_email="ian@cloudoon.com,info@cloudpap.com,ian@truehost.cloud,konoko5895@ikuromi.com"
email_subject="Plesk Installation Information"

# Log file for email status
email_log_file="/var/log/email.log"

# Function to extract content and send email
extract_and_send_content() {
  # Extract content between "Congratulations!" and the ending sentence
  content=$(sed -n '/Congratulations!/,/Please check out our assistance options: https://www.plesk.com/professional-services/p' "$log_file")

  # Send email with content and log the output
  if echo -e "$content" | mailx -s "$email_subject" "$recipient_email" >> "$email_log_file" 2>&1; then
    echo "$(date): $recipient_email have received the emails successfully." >> "$email_log_file"
  else
    error=$(tail -n 1 "$email_log_file")
    echo "$(date): The emails were not sent successfully. Error: $error" >> "$email_log_file"
  fi
}

# Check for the "Congratulations!" sentence continuously
while true; do
  if grep -q 'Congratulations!' "$log_file"; then
    extract_and_send_content
    break  # Exit the loop after sending the email
  fi
  sleep 10  # Adjust the sleep interval as needed
done


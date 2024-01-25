#!/bin/bash

# Path to the installation log file
log_file="/var/log/install.log"

# Email configuration
recipient_email="ian@cloudoon.com,info@cloudpap.com,ian@truehost.cloud"
email_subject="Plesk Installation Information"

# Log file for email status
email_log_file="/var/log/email.log"

# Function to extract content and send email
extract_and_send_content() {
  # Extract content between "Congratulations!" and the ending sentence
  content=$(sed -n '/Congratulations!/,/If you would like to migrate your subscriptions/p' "$log_file")

  # Send email with content and log the output
  echo -e "$content" | mailx -s "$email_subject" "$recipient_email" >> "$email_log_file" 2>&1
}

# Check for the "Congratulations!" sentence continuously
while true; do
  if grep -q 'Congratulations!' "$log_file"; then
    extract_and_send_content
    break  # Exit the loop after sending the email
  fi
  sleep 10  # Adjust the sleep interval as needed
done

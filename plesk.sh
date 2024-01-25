#!/bin/bash

# Path to the installation log file
log_file="/var/log/install.log"

# Email configuration
recipient_email="info@truehost.cloud"
email_subject="Plesk Installation Information"

# Function to extract content and send email
extract_and_send_content() {
  # Extract content between "Congratulations!" and the ending sentence
  content=$(sed -n '/Congratulations!/,/If you would like to migrate your subscriptions/p' "$log_file")

  # Send email with content
  echo -e "$content" | mailx -s "$email_subject" "$recipient_email"
}

# Check for the "Congratulations!" sentence continuously
while true; do
  if grep -q 'Congratulations!' "$log_file"; then
    extract_and_send_content
    break  # Exit the loop after sending the email
  fi
  sleep 10  # Adjust the sleep interval as needed
done

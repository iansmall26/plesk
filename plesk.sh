#!/bin/bash

# Path to the installation log file
log_file="/var/log/install.log"

# Email configuration
recipient_email="cloudpapke@gmail.com"
email_subject="Plesk Installation URLs"

# Function to extract URLs and send email
extract_and_send_urls() {
  # Extract URLs from the installation log
  urls=($(grep -oP 'https://[^ ]+' "$log_file"))

  # Send email with URLs
  echo -e "Plesk Installation URLs:\n${urls[@]}" | mailx -s "$email_subject" "$recipient_email"
}

# Check for URLs continuously
while true; do
  if grep -q 'https://' "$log_file"; then
    extract_and_send_urls
    break  # Exit the loop after sending the email
  fi
  sleep 10  # Adjust the sleep interval as needed
done

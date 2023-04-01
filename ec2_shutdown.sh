#!/bin/bash

#Take instance ID as input
read -p "Enter the instance ID: " INSTANCE_ID

# Replace the instance ID with your own
#INSTANCE_ID="i-0123456789abcdef"

# Get the current day and time
DAY=$(date +%u)
HOUR=$(date +%H)


# Stop the instance on Friday at 6 PM
if [ $DAY -eq 5 ] && [ $HOUR -eq 18 ]; then
    echo 'Stopping instance'
    aws ec2 stop-instances --instance-ids $INSTANCE_ID
fi

# Start the instance on Monday at 6 AM
if [ $DAY -eq 1 ] && [ $HOUR -eq 6 ]; then
    echo 'Starting instance'
    aws ec2 start-instances --instance-ids $INSTANCE_ID
fi
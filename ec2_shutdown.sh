#!/bin/bash

REGION="us-east-1"

# Get all instance IDs
INSTANCE_IDS=$(aws ec2 describe-instances --region $REGION --query "Reservations[*].Instances[*].InstanceId" --output text)
echo $INSTANCE_IDS
# Get the current day and time
DAY=$(date +%u)
HOUR=$(date +%H)
echo $DAY
echo $HOUR

# Stop the instance on Friday at 6 PM
if [ $DAY -eq 6 ] && [ $HOUR -eq 19 ]; then
    echo 'Stopping instance'
    aws ec2 stop-instances --region $REGION --instance-ids $INSTANCE_IDS
fi

# Start the instance on Monday at 6 AM
if [ $DAY -eq 1 ] && [ $HOUR -eq 6 ]; then
    echo 'Starting instance'
    aws ec2 start-instances --region $REGION --instance-ids $INSTANCE_IDS
fi
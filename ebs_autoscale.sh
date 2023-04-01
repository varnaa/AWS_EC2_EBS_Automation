#!/bin/bash

# Set the storage threshold
THRESHOLD=10

# Set the instance ID
INSTANCE_ID="i-0123456789abcdef"

# Get the block device mappings
BLOCK_DEVICE_MAPPINGS=$(aws ec2 describe-instances --instance-ids $INSTANCE_ID --query 'Reservations[*].Instances[*].BlockDeviceMappings[*].Ebs.VolumeId' --output text)

# Loop through the block device mappings
for VOLUME_ID in $BLOCK_DEVICE_MAPPINGS; do
    # Get the current size of the volume
    CURRENT_SIZE=$(aws ec2 describe-volumes --volume-ids $VOLUME_ID --query 'Volumes[*].Size' --output text)

    # Get the current usage of the volume (replace this command with one that works on your server)
    CURRENT_USAGE=$(ssh -i /path/to/key.pem ec2-user@$INSTANCE_IP "df -h | grep $VOLUME_ID | awk '{print $5}' | sed 's/%//g'")

    # Check if the current usage is greater than or equal to the threshold
    if (( $CURRENT_USAGE >= $THRESHOLD )); then
        # Calculate the new size
        NEW_SIZE=$((CURRENT_SIZE * 2))

        # Resize the volume
        aws ec2 modify-volume --volume-id $VOLUME_ID --size $NEW_SIZE
    fi
done
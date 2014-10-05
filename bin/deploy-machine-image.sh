#!/bin/sh

if [ ! $# -eq 1 ]; then echo "No AMI id specified"; exit 1; fi

image_id=$1

instance_details=$(aws ec2 run-instances \
 --image-id $image_id \
 --instance-type t2.micro \
 --security-groups WordPress \
 --placement AvailabilityZone=us-east-1a \
 --region=us-east-1 \
 --count=1 \
)

# Set the Name tag of the instance from the Name tag of the image
instance_id=$(echo $instance_details | jq -r ".Instances[0].InstanceId" | sed 's/"//g')
name=$(aws ec2 describe-images --image-ids $image_id | jq -r ".Images[0].Tags[0].Value")
aws ec2 create-tags --resources $instance_id --tags Key=Name,Value=$name


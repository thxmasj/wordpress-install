#!/bin/sh

if [ ! $# -eq 1 ]; then echo "No AMI id specified"; exit 1; fi

image_id=$1
subnet_id=$(aws ec2 describe-subnets --filters "Name=tag:Name,Values=WordPressWeb" | jq -r ".Subnets[].SubnetId")
sg_id=$(aws ec2 describe-security-groups --filters "Name=group-name,Values=WordPressWeb" | jq -r ".SecurityGroups[].GroupId")

instance_details=$(aws ec2 run-instances \
 --image-id $image_id \
 --instance-type t2.micro \
 --subnet-id $subnet_id \
 --security-group-ids $sg_id \
 --key-name thomasjohansen.it \
 --associate-public-ip-address \
 --count=1 \
)

# Set the Name tag of the instance from the Name tag of the image
instance_id=$(echo $instance_details | jq -r ".Instances[0].InstanceId" | sed 's/"//g')
name=$(aws ec2 describe-images --image-ids $image_id | jq -r ".Images[0].Tags[0].Value")
aws ec2 create-tags --resources $instance_id --tags Key=Name,Value=$name


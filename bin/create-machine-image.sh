#!/bin/sh

image_name=WordPress$(date +"%Y%m%d%H%M%S")
packer build -var "name=$image_name" packer/wordpress.json > /tmp/log-$image_name

# Print the id of the created image
image_id=$(aws ec2 describe-images --owner self --filters "Name=name,Values=$image_name" | jq -r ".Images[].ImageId")
echo $image_id


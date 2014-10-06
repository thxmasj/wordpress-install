#!/bin/sh

#
# VPC
#

echo "Creating VPC..."
vpc_id=$(aws ec2 create-vpc --cidr-block 172.32.0.0/16 | jq -r ".Vpc.VpcId")

echo "Creating subnets..."
subnet_web_id=$(aws ec2 create-subnet --vpc-id $vpc_id --cidr-block 172.32.1.0/24 --availability-zone us-east-1a | jq -r ".Subnet.SubnetId")
subnet_db1_id=$(aws ec2 create-subnet --vpc-id $vpc_id --cidr-block 172.32.2.0/24 --availability-zone us-east-1a | jq -r ".Subnet.SubnetId")
subnet_db2_id=$(aws ec2 create-subnet --vpc-id $vpc_id --cidr-block 172.32.3.0/24 --availability-zone us-east-1c | jq -r ".Subnet.SubnetId")

echo "Setting up Internet gateway..."
igw_id=$(aws ec2 create-internet-gateway | jq -r ".InternetGateway.InternetGatewayId")
aws ec2 attach-internet-gateway --internet-gateway-id $igw_id --vpc-id $vpc_id
route_table_id=$(aws ec2 describe-route-tables --filters 'Name=route.gateway-id,Values=$igw_id' | jq -r ".RouteTables[].RouteTableId")
aws ec2 create-route --route-table-id rtb-b2bc39d7 --destination-cidr-block 0.0.0.0/0 --gateway-id $igw_id

#
# FIREWALLS
#

echo "Creating web security group..."
sg_web_id=$(aws ec2 create-security-group --vpc-id $vpc_id --group-name WordPressWeb --description "WordPress web" | jq -r ".GroupId")
aws ec2 authorize-security-group-ingress --group-id $sg_web_id --protocol tcp --port 22 --cidr 0.0.0.0/0
aws ec2 authorize-security-group-ingress --group-id $sg_web_id --protocol tcp --port 443 --cidr 0.0.0.0/0

echo "Creating database security group..."
sg_db_id=$(aws ec2 create-security-group --vpc-id $vpc_id --group-name WordPressDB --description "WordPress database" | jq -r ".GroupId")
aws ec2 authorize-security-group-ingress --group-id $sg_db_id --protocol tcp --port 3306 --source-group $sg_web_id

#
# TAGS
#

echo "Creating tags..."
aws ec2 create-tags --resources $vpc_id --tags Key=Name,Value="WordPress"
aws ec2 create-tags --resources $subnet_web_id --tags Key=Name,Value="WordPressWeb"
aws ec2 create-tags --resources $subnet_db1_id --tags Key=Name,Value="WordPressDB1"
aws ec2 create-tags --resources $subnet_db2_id --tags Key=Name,Value="WordPressDB2"

#
# DATABASE
#

echo "Creating database subnet group..."
aws rds create-db-subnet-group --db-subnet-group-name WordPressDB --db-subnet-group-description WordPressDB --subnet-ids $subnet_db1_id $subnet_db2_id

echo "Creating database..."
aws rds create-db-instance \
 --db-name wordpress \
 --db-instance-identifier WordPressDB \
 --allocated-storage 5 \
 --engine mysql \
 --db-instance-class db.t2.micro \
 --master-username wordpress \
 --master-user-password wordpress \
 --preferred-maintenance-window Mon:02:00-Mon:02:30 \
 --preferred-backup-window 02:30-03:00 \
 --availability-zone us-east-1a \
 --db-subnet-group-name WordPressDB \
 --vpc-security-group-ids $sg_db_id


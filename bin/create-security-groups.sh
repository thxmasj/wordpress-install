#!/bin/sh

aws ec2 create-security-group --group-name WordPress --description WordPress
aws ec2 authorize-security-group-ingress --group-name WordPress --protocol tcp --port 22 --cidr 0.0.0.0/0
aws ec2 authorize-security-group-ingress --group-name WordPress --protocol tcp --port 443 --cidr 0.0.0.0/0

aws ec2 create-security-group --group-name WordPressDB --description "WordPress database"
aws ec2 authorize-security-group-ingress --group-name WordPressDB --protocol tcp --port 3306 --source-group WordPress


#!/bin/sh

security_group_id=$(aws ec2 describe-security-groups --group-names WordPressDB | jq -r ".SecurityGroups[].GroupId")

aws rds create-db-instance \
 --db-name wordpress \
 --db-instance-identifier WordPress \
 --allocated-storage 5 \
 --engine mysql \
 --db-instance-class db.t2.micro \
 --master-username wordpress \
 --master-user-password wordpress \
 --preferred-maintenance-window Mon:02:00-Mon:02:30 \
 --preferred-backup-window 02:30-03:00 \
 --availability-zone us-east-1a \
 --vpc-security-group-ids $security_group_id


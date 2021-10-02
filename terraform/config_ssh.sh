#!/bin/bash
yum update -y
cat /home/ec2-user/id_rsa.pub >> /home/ec2-user/.ssh/authorized_keys

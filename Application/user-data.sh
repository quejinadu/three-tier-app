#!/bin/bash

# get admin privileges
sudo su

# install httpd 
yum update -y
yum install -y httpd.x86_64
systemctl start httpd.service
systemctl enable httpd.service
echo "Did you know Cint is a global software leader in digital insights? You are getting this from $(hostname -f)" > /var/www/html/index.html
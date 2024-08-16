#!/bin/bash
yum -y update
yum -y install httpd
myip=`curl http://169.254.169.254/latest/meta-data/local-ipv4`
echo "<h1>Welcome to ACS730 Final project! My private IP is $myip <font color="turquoise"> in prod environment</font></h1><br>Built by Terraform Group 10!"  >  /var/www/html/index.html
sudo systemctl start httpd
sudo systemctl enable httpd
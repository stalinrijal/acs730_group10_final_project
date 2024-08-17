#!/bin/bash
yum -y update
yum -y install httpd
aws s3 cp s3://acs730-group10-bucket/images/sample.jpg /var/www/html/image.jpg
myip='curl http://169.254.169.254/latest/meta-data/local-ipv4'
echo '<h1>Welcome to ACS730 Final project! Group 10: : Stalin, Anup, Bhupendra --- My private IP is '"$myip"' <font color="turquoise"> in prod environment</font></h1><br>Built by Terraform Group 10!' > /var/www/html/index.html
sudo systemctl start httpd
sudo systemctl enable httpd
#!/bin/bash
yum -y update
yum -y install httpd

# Download image from S3
aws s3 cp s3://acs730-group10-bucket/images/sample.jpg /var/www/html/image.jpg

# Retrieve the instance's private IP address
myip=$(curl -s http://169.254.169.254/latest/meta-data/local-ipv4)

# Create an HTML page with IP and image
echo '<h1>Welcome to ACS730 Final project! Group 10: Stalin, Anup, Bhupendra --- My private IP is '"$myip"' <font color="turquoise"> in prod environment</font></h1><br><img src="image.jpg" alt="Group 10 Image"><br>Built by Terraform Group 10!' > /var/www/html/index.html

# Start and enable Apache HTTP server
sudo systemctl start httpd
sudo systemctl enable httpd
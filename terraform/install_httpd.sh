#!/bin/bash
yum update -y
yum install -y httpd
systemctl start httpd
systemctl enable httpd
echo "<h1>Hello from ACS730 Webserver</h1>" > /var/www/html/index.html
echo "<p>Environment: ${env}</p>" >> /var/www/html/index.html
echo "<p>Welcome to ACS730 Final project! Group 10: Stalin, Anup, Bhupendra</p>" >> /var/www/html/index.html
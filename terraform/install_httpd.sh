#!/bin/bash
yum update -y
yum install -y httpd
systemctl start httpd
systemctl enable httpd
aws s3 cp s3://acs730-group10-bucket/images/sample.jpg /var/www/html/image.jpg
# PUBLIC_IP=$(curl -s http://169.254.169.254/latest/meta-data/public-ipv4)
echo "<h1>Hello from ACS730 Webserver</h1>" > /var/www/html/index.html
echo "<p>Environment: ${env}</p>" >> /var/www/html/index.html
echo "<p>Welcome to ACS730 Final project! Group 10: Stalin, Anup, Bhupendra</p>" >> /var/www/html/index.html

# #!/bin/bash
# yum -y update
# yum -y install httpd

# # Download image from S3
# aws s3 cp s3://acs730-group10-bucket/images/sample.jpg /var/www/html/image.jpg

# # Retrieve the instance's private IP address
# myip=$(curl -s http://169.254.169.254/latest/meta-data/local-ipv4)

# # Create an HTML page with IP and image
# echo '<h1>Welcome to ACS730 Final project! Group 10: Stalin, Anup, Bhupendra --- My IP is '"$myip"' <font color="turquoise"> in prod environment</font></h1><br><img src="image.jpg" alt="Group 10 Image"><br>Built by Terraform Group 10!' > /var/www/html/index.html

# # Start and enable Apache HTTP server
# sudo systemctl start httpd
# sudo systemctl enable httpd

# Web Server Instances in Public Subnets
resource "aws_instance" "webserver1" {
  ami                    = var.linux_ami_id
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.public_subnet1.id
  vpc_security_group_ids = [aws_security_group.public_sg.id]
  key_name               = aws_key_pair.ssh_key.key_name
  user_data = base64encode(templatefile("${path.module}/install_httpd.sh", {
    env = var.env
  }))
  tags = {
    Name = "Webserver1"
  }
}

resource "aws_instance" "webserver2" {
  ami                    = var.linux_ami_id
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.public_subnet2.id
  vpc_security_group_ids = [aws_security_group.public_sg.id]
  associate_public_ip_address = true
  key_name               = aws_key_pair.ssh_key.key_name
  user_data = base64encode(templatefile("${path.module}/install_httpd.sh", {
    env = var.env
  }))
  tags = {
    Name = "Webserver2 (Bastion)"
  }
}

resource "aws_instance" "webserver3" {
  ami                    = var.linux_ami_id
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.public_subnet3.id
  vpc_security_group_ids = [aws_security_group.public_sg.id]
  key_name               = aws_key_pair.ssh_key.key_name
  tags = {
    Name = "Webserver3",
    Deployment = "Ansible"
  }
}

resource "aws_instance" "webserver4" {
  ami                    = var.linux_ami_id
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.public_subnet4.id
  vpc_security_group_ids = [aws_security_group.public_sg.id]
  key_name               = aws_key_pair.ssh_key.key_name
  associate_public_ip_address = true
  tags = {
    Name = "Webserver4",
    Deployment = "Ansible"
  }
}

# Web Server Instances in Private Subnets
resource "aws_instance" "webserver5" {
  ami                    = var.linux_ami_id
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.private_subnet1.id
  vpc_security_group_ids = [aws_security_group.private_sg.id]
  key_name               = aws_key_pair.ssh_key.key_name
  associate_public_ip_address = true
  user_data = <<-EOF
    #!/bin/bash
    sudo yum update -y
    sudo yum install -y httpd
    sudo systemctl start httpd
    sudo systemctl enable httpd
    echo "Apache HTTP Server is installed and running - Group 10 : Stalin, Anup, Bhupendra" | sudo tee /var/www/html/index.html
  EOF

  tags = {
    Name = "Webserver5",
    Deployment = "terraform"
  }
}

resource "aws_instance" "webserver6" {
  ami                    = var.linux_ami_id
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.private_subnet2.id
  vpc_security_group_ids = [aws_security_group.private_sg.id]
  key_name               = aws_key_pair.ssh_key.key_name
  associate_public_ip_address = true
  tags = {
    Name = "Webserver6"
  }
}

resource "aws_key_pair" "ssh_key" {
  key_name   = "linux"
  public_key = file("linux.pub")
}
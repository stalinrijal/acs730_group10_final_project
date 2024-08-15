# Web Server Instances in Public Subnets
resource "aws_instance" "webserver1" {
  ami                    = var.linux_ami_id
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.public_subnet1.id
  vpc_security_group_ids = [aws_security_group.public_sg.id]
  key_name               = aws_key_pair.ssh_key.key_name

  tags = {
    Name = "Webserver1"
  }

  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              yum install -y httpd
              systemctl start httpd
              systemctl enable httpd
              EOF
}

resource "aws_instance" "webserver2" {
  ami                    = var.linux_ami_id
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.public_subnet2.id
  vpc_security_group_ids = [aws_security_group.public_sg.id]
  associate_public_ip_address = true
  key_name               = aws_key_pair.ssh_key.key_name

  tags = {
    Name = "Webserver2 (Bastion)"
  }

  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              yum install -y httpd
              systemctl start httpd
              systemctl enable httpd
              EOF
}

resource "aws_instance" "webserver3" {
  ami                    = var.linux_ami_id
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.public_subnet3.id
  vpc_security_group_ids = [aws_security_group.public_sg.id]
  key_name               = aws_key_pair.ssh_key.key_name

  tags = {
    Name = "Webserver3"
  }

  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              yum install -y httpd
              systemctl start httpd
              systemctl enable httpd
              EOF
}

resource "aws_instance" "webserver4" {
  ami                    = var.linux_ami_id
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.public_subnet4.id
  vpc_security_group_ids = [aws_security_group.public_sg.id]
  key_name               = aws_key_pair.ssh_key.key_name

  tags = {
    Name = "Webserver4"
  }

  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              yum install -y httpd
              systemctl start httpd
              systemctl enable httpd
              EOF
}

# Web Server Instances in Private Subnets
resource "aws_instance" "webserver5" {
  ami                    = var.linux_ami_id
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.private_subnet1.id
  vpc_security_group_ids = [aws_security_group.private_sg.id]
  key_name               = aws_key_pair.ssh_key.key_name

  tags = {
    Name = "Webserver5"
  }
}

resource "aws_instance" "webserver6" {
  ami                    = var.linux_ami_id
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.private_subnet2.id
  vpc_security_group_ids = [aws_security_group.private_sg.id]
  key_name               = aws_key_pair.ssh_key.key_name

  tags = {
    Name = "Webserver6"
  }
}

resource "aws_key_pair" "ssh_key" {
  key_name   = "linux"
  public_key = file("linux.pub")
}
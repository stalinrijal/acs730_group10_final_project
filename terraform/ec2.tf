# Web Server Instances in Public Subnets
resource "aws_instance" "webserver1" {
  ami                    = "ami-0c94855ba95c71c99" # Amazon Linux 2 AMI (Change as needed)
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.public_subnet1.id
  vpc_security_group_ids = [aws_security_group.public_sg.id]

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
  ami                    = "ami-0c94855ba95c71c99" # Amazon Linux 2 AMI (Change as needed)
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.public_subnet2.id
  vpc_security_group_ids = [aws_security_group.public_sg.id]

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
  ami                    = "ami-0c94855ba95c71c99" # Amazon Linux 2 AMI (Change as needed)
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.public_subnet3.id
  vpc_security_group_ids = [aws_security_group.public_sg.id]

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
  ami                    = "ami-0c94855ba95c71c99" # Amazon Linux 2 AMI (Change as needed)
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.public_subnet4.id
  vpc_security_group_ids = [aws_security_group.public_sg.id]

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
  ami                    = "ami-0c94855ba95c71c99" # Amazon Linux 2 AMI (Change as needed)
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.private_subnet1.id
  vpc_security_group_ids = [aws_security_group.private_sg.id]

  tags = {
    Name = "Webserver5"
  }

  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              yum install -y httpd
              systemctl start httpd
              systemctl enable httpd
              EOF
}

resource "aws_instance" "webserver6" {
  ami                    = "ami-0c94855ba95c71c99" # Amazon Linux 2 AMI (Change as needed)
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.private_subnet2.id
  vpc_security_group_ids = [aws_security_group.private_sg.id]

  tags = {
    Name = "Webserver6"
  }

  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              yum install -y httpd
              systemctl start httpd
              systemctl enable httpd
              EOF
}

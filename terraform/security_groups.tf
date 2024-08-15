# Public Security Group
resource "aws_security_group" "public_sg" {
  name        = "public_sg"
  vpc_id      = aws_vpc.final_project_vpc.id
  description = "Allow SSH and HTTP access from anywhere"

  ingress {
    description = "Allow SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow all outbound"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "public_sg"
  }
}

# Private Security Group
resource "aws_security_group" "private_sg" {
  name        = "private_sg"
  vpc_id      = aws_vpc.final_project_vpc.id
  description = "Allow SSH from bastion and HTTP from the internet"

  ingress {
    description = "Allow SSH from public SG"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    security_groups = [
      aws_security_group.public_sg.id
    ]
  }

  ingress {
    description = "Allow HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow all outbound"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "private_sg"
  }
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 3.27"
    }
  }
  required_version = ">=0.14"
}

provider "aws" {
  profile = "default"
  region  = "us-east-1"
}

data "terraform_remote_state" "network" {
  backend = "s3"
  config = {
    bucket = "prod-bucket-sgaire3"
    key    = "prod/network/terraform.tfstate"
    region = "us-east-1"
  }
}

data "aws_ami" "latest_amazon_linux" {
  owners      = ["amazon"]
  most_recent = true
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

locals {
  default_tags = merge(var.default_tags, { "env" = var.env })
  name_prefix  = "${var.prefix}-${var.env}"
}

resource "aws_security_group" "private_sg" {
  name        = "${local.name_prefix}-private-sg"
  description = "Security group for private instances"
  vpc_id      = data.terraform_remote_state.network.outputs.vpc_id

  ingress {
    description      = "HTTP from everywhere"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  ingress {
    description      = "SSH from everywhere"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(local.default_tags,
    {
      "Name" = "${local.name_prefix}-private-sg"
    }
  )
}

# Private instances
resource "aws_instance" "private_instances_prod" {
  count                  = 2
  ami                    = data.aws_ami.latest_amazon_linux.id
  instance_type          = lookup(var.instance_type, var.env)
  key_name               = aws_key_pair.ssh_key.key_name
  vpc_security_group_ids = [aws_security_group.private_sg.id]
  subnet_id              = data.terraform_remote_state.network.outputs.private_subnet_ids[count.index]

  tags = merge(local.default_tags,
    {
      "Name" = "${local.name_prefix}-vm${count.index + 1}"
    }
  )
}

# EBS volumes for Private Instances
resource "aws_ebs_volume" "private_instance_ebs" {
  count             = 2
  availability_zone = aws_instance.private_instances_prod[count.index].availability_zone
  size              = 20  # Size in GB, adjust as needed

  tags = merge(local.default_tags,
    {
      "Name" = "${local.name_prefix}-private-instance-ebs-${count.index + 1}"
    }
  )
}

# Attach EBS volumes to Private Instances
resource "aws_volume_attachment" "private_instance_ebs_att" {
  count       = 2
  device_name = "/dev/sdh"
  volume_id   = aws_ebs_volume.private_instance_ebs[count.index].id
  instance_id = aws_instance.private_instances_prod[count.index].id
}

resource "aws_key_pair" "ssh_key" {
  key_name   = "${var.prefix}-ssh-key"
  public_key = file("${var.prefix}.pub")
}
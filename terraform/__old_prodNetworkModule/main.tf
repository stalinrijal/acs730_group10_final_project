# Terraform Config file (main.tf). This has provider block (AWS) and config for provisioning one EC2 instance resource.  

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

# Data source for availability zones in us-east-1
data "aws_availability_zones" "available" {
  state = "available"
}

# Define tags locally
locals {
  default_tags = merge(var.default_tags, { "env" = var.env })
}

resource "aws_vpc" "prod_vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = merge(local.default_tags,
    {
      "Name" = "${var.prefix}-vpc"
    }
  )
}

resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.prod_vpc.id

  tags = merge(local.default_tags,
    {
      "Name" = "${var.prefix}-igw"
    }
  )
}

resource "aws_subnet" "prod_private" {
  count             = length(var.private_cidr_blocks)
  vpc_id            = aws_vpc.prod_vpc.id
  cidr_block        = var.private_cidr_blocks[count.index]
  availability_zone = data.aws_availability_zones.available.names[count.index]

  tags = merge(local.default_tags,
    {
      "Name" = "${var.prefix}-private-subnet"
    }
  )
}

resource "aws_route_table" "prod_private" {
  count  = 2
  vpc_id = aws_vpc.prod_vpc.id

  tags = merge(local.default_tags,
    {
      "Name" = "${var.prefix}-private-subnet"
    }
  )
}

resource "aws_route_table_association" "prod_private" {
  count          = 2
  subnet_id      = aws_subnet.prod_private[count.index].id
  route_table_id = aws_route_table.prod_private[count.index].id
}


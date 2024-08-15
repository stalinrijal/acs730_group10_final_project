# VPC
resource "aws_vpc" "final_project_vpc" {
  cidr_block           = "10.1.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "final_project_vpc"
  }
}

# Internet Gateway
resource "aws_internet_gateway" "final_project_igw" {
  vpc_id = aws_vpc.final_project_vpc.id

  tags = {
    Name = "final_project_igw"
  }
}

# Public Subnets
resource "aws_subnet" "public_subnet1" {
  vpc_id                  = aws_vpc.final_project_vpc.id
  cidr_block              = "10.1.1.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "public_subnet1"
  }
}

resource "aws_subnet" "public_subnet2" {
  vpc_id                  = aws_vpc.final_project_vpc.id
  cidr_block              = "10.1.2.0/24"
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = true

  tags = {
    Name = "public_subnet2"
  }
}

resource "aws_subnet" "public_subnet3" {
  vpc_id                  = aws_vpc.final_project_vpc.id
  cidr_block              = "10.1.3.0/24"
  availability_zone       = "us-east-1c"
  map_public_ip_on_launch = true

  tags = {
    Name = "public_subnet3"
  }
}

resource "aws_subnet" "public_subnet4" {
  vpc_id                  = aws_vpc.final_project_vpc.id
  cidr_block              = "10.1.4.0/24"
  availability_zone       = "us-east-1d"
  map_public_ip_on_launch = true

  tags = {
    Name = "public_subnet4"
  }
}

# Private Subnets
resource "aws_subnet" "private_subnet1" {
  vpc_id                  = aws_vpc.final_project_vpc.id
  cidr_block              = "10.1.5.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = false

  tags = {
    Name = "private_subnet1"
  }
}

resource "aws_subnet" "private_subnet2" {
  vpc_id                  = aws_vpc.final_project_vpc.id
  cidr_block              = "10.1.6.0/24"
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = false

  tags = {
    Name = "private_subnet2"
  }
}

# NAT Gateway
resource "aws_eip" "nat_eip" {
  vpc = true

  tags = {
    Name = "nat_eip"
  }
}

resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.public_subnet1.id

  tags = {
    Name = "nat"
  }
}

# Route Tables
resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.final_project_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.final_project_igw.id
  }

  tags = {
    Name = "public_route_table"
  }
}

resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.final_project_vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat.id
  }

  tags = {
    Name = "private_route_table"
  }
}

# Route Table Associations
resource "aws_route_table_association" "public1" {
  subnet_id      = aws_subnet.public_subnet1.id
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_route_table_association" "public2" {
  subnet_id      = aws_subnet.public_subnet2.id
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_route_table_association" "public3" {
  subnet_id      = aws_subnet.public_subnet3.id
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_route_table_association" "public4" {
  subnet_id      = aws_subnet.public_subnet4.id
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_route_table_association" "private1" {
  subnet_id      = aws_subnet.private_subnet1.id
  route_table_id = aws_route_table.private_route_table.id
}

resource "aws_route_table_association" "private2" {
  subnet_id      = aws_subnet.private_subnet2.id
  route_table_id = aws_route_table.private_route_table.id
}

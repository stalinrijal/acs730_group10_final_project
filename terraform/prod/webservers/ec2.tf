locals {
  default_tags = merge(var.default_tags, { "env" = var.env })
  name_prefix  = "${var.prefix}-${var.env}"
}

data "aws_ami" "latest_amazon_linux" {
  owners      = ["amazon"]
  most_recent = true
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

# Bastion Host
resource "aws_instance" "bastion" {
  ami                         = data.aws_ami.latest_amazon_linux.id
  instance_type               = lookup(var.instance_type, var.env)
  key_name                    = aws_key_pair.ssh_key.key_name
  vpc_security_group_ids      = [aws_security_group.bastion_sg.id]
  subnet_id                   = data.terraform_remote_state.network.outputs.public_subnet_ids[1]
  associate_public_ip_address = true

  tags = merge(local.default_tags,
    {
      "Name" = "${local.name_prefix}-bastion"
    }
  )
}

# Normal Public Instance
resource "aws_instance" "public_instance" {
  ami                         = data.aws_ami.latest_amazon_linux.id
  instance_type               = lookup(var.instance_type, var.env)
  key_name                    = aws_key_pair.ssh_key.key_name
  vpc_security_group_ids      = [aws_security_group.public_sg.id]
  subnet_id                   = data.terraform_remote_state.network.outputs.public_subnet_ids[0]
  associate_public_ip_address = true

  tags = merge(local.default_tags,
    {
      "Name" = "${local.name_prefix}-public-instance"
    }
  )
}

# Private instances
resource "aws_instance" "private_instances" {
  count                  = 2
  ami                    = data.aws_ami.latest_amazon_linux.id
  instance_type          = lookup(var.instance_type, var.env)
  key_name               = aws_key_pair.ssh_key.key_name
  vpc_security_group_ids = [aws_security_group.private_sg.id]
  subnet_id              = data.terraform_remote_state.network.outputs.private_subnet_ids[count.index]

  user_data = templatefile("${path.module}/install_httpd.sh.tpl",
    {
      env    = upper(var.env),
      prefix = upper(var.prefix)
    }
  )

  tags = merge(local.default_tags,
    {
      "Name" = "${local.name_prefix}-vm${count.index + 1}"
    }
  )
}


# Elastic IP
resource "aws_eip" "static_eip" {
  instance = aws_instance.bastion.id
  tags = merge(local.default_tags,
    {
      "Name" = "${var.prefix}-eip"
    }
  )
}

resource "aws_key_pair" "ssh_key" {
  key_name   = var.prefix
  public_key = file("${var.prefix}.pub")
}

#########
############

## EBS volumes for Private Instances
#resource "aws_ebs_volume" "private_instance_ebs" {
#  count             = 2
#  availability_zone = aws_instance.private_instances[count.index].availability_zone
#  size              = 20
#
#  tags = merge(local.default_tags,
#    {
#      "Name" = "${local.name_prefix}-private-instance-ebs-${count.index + 1}"
#    }
#  )
#}

## Attach EBS volumes to Private Instances
#resource "aws_volume_attachment" "private_instance_ebs_att" {
#  count       = 2
#  device_name = "/dev/sdh"
#  volume_id   = aws_ebs_volume.private_instance_ebs[count.index].id
#  instance_id = aws_instance.private_instances[count.index].id
#}

## EBS volume for Public Instance
#resource "aws_ebs_volume" "public_instance_ebs" {
#  availability_zone = aws_instance.public_instance.availability_zone
#  size              = 20
#
#  tags = merge(local.default_tags,
#    {
#      "Name" = "${local.name_prefix}-public-instance-ebs"
#    }
#  )
#}
#
## Attach EBS volume to Public Instance
#resource "aws_volume_attachment" "public_instance_ebs_att" {
#  device_name = "/dev/sdh"
#  volume_id   = aws_ebs_volume.public_instance_ebs.id
#  instance_id = aws_instance.public_instance.id
#}

## EBS volume for Bastion Host
#resource "aws_ebs_volume" "bastion_ebs" {
#  availability_zone = aws_instance.bastion.availability_zone
#  size              = 20
#
#  tags = merge(local.default_tags,
#    {
#      "Name" = "${local.name_prefix}-bastion-ebs"
#    }
#  )
#}
#
## Attach EBS volume to Bastion Host
#resource "aws_volume_attachment" "bastion_ebs_att" {
#  device_name = "/dev/sdh"
#  volume_id   = aws_ebs_volume.bastion_ebs.id
#  instance_id = aws_instance.bastion.id
#}
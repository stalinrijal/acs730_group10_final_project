#Config:
variable "env" {
  default     = "prod"
  type        = string
  description = "Bucket name"
}

variable "bucket_name" {
  default     = "acs730-group10-bucket"
  type        = string
  description = "Bucket name"
}

variable "state_file" {
  default     = "group10/dev/terraform.tfstate"
  type        = string
  description = "State file path"
}


# Variables
variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "us-east-1"
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}

variable "linux_ami_id" {
  description = "AMI ID for EC2 instances"
  type        = string
  default     = "ami-0ae8f15ae66fe8cda" # Amazon Linux 2 AMI (Change as needed)
}

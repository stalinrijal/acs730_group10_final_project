#Config:
variable "bucket_name" {
  default     = "non-prod-bucket-sgaire3"
  type        = string
  description = "Bucket name"
}

variable "state_file" {
  default     = "dev/network/terraform.tfstate"
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

variable "ami_id" {
  description = "AMI ID for EC2 instances"
  type        = string
  default     = "ami-0c94855ba95c71c99" # Amazon Linux 2 AMI (Change as needed)
}

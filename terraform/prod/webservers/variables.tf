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


# Instance type
variable "instance_type" {
  default = {
    "prod" = "t2.micro"
    "test" = "t2.micro"
    "dev"  = "t2.micro"
  }
  description = "Type of the instance"
  type        = map(string)
}

# Default tags
variable "default_tags" {
  default = {
    "Owner" = "CAAacs730"
    "App"   = "Web"
  }
  type        = map(any)
  description = "Default tags to be appliad to all AWS resources"
}

# Prefix to identify resources
variable "prefix" {
  default     = "assmt1"
  type        = string
  description = "Name prefix"
}


# Variable to signal the current environment 
variable "env" {
  default     = "prod"
  type        = string
  description = "Production Environment"
}

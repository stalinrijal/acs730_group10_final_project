terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 3.27"
    }
  }
  required_version = ">=0.14"
}

# Provider configuration
provider "aws" {
  region = var.aws_region
}

terraform {
  backend "s3" {
    bucket = "acs730-group10-bucket"
    key    =  "group10/dev/terraform.tfstate"
    region = "us-east-1"
  }
}
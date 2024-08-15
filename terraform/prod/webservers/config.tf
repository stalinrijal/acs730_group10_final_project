terraform {
  backend "s3" {
    bucket = var.bucket_name          // Bucket from where to GET Terraform State
    key    = var.state_file          // Object name in the bucket to GET Terraform State
    region = "us-east-1"            // Region where bucket created
  }
}

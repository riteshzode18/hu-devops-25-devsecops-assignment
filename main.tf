terraform {
  required_version = ">= 1.3.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}


resource "aws_s3_bucket" "example" {
  bucket = "example-secure-bucket-123456"
  acl    = "private"
  tags = {
    Name        = "SecureBucket"
    Environment = "Dev"
  }
}
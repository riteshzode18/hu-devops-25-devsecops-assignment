provider "aws" {
  region = "us-east-1"
}

resource "aws_s3_bucket" "secure_bucket" {
  bucket = "secure-s3-bucket-feature2"
  acl    = "private"

  # Enable server-side encryption
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }

  # Enable versioning
  versioning {
    enabled = true
  }

  # Enable access logging
  logging {
    target_bucket = "logging-bucket-name"
    target_prefix = "log/"
  }

  # Add lifecycle configuration
  lifecycle_rule {
    id      = "lifecycle"
    enabled = true

    expiration {
      days = 30
    }

    noncurrent_version_expiration {
      days = 15
    }
  }

  # Cross-region replication (replace with your actual configuration)
#   replication_configuration {
#     role = "arn:aws:iam::account-id:role/replication-role"
#     rules {
#       id     = "replication-rule"
#       status = "Enabled"

#       destination {
#         bucket = "arn:aws:s3:::replicated-bucket-name"
#       }
#     }
#   }
}

resource "aws_s3_bucket_public_access_block" "secure_bucket_block" {
  bucket                  = aws_s3_bucket.secure_bucket.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
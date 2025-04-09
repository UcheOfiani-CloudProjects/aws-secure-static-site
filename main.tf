resource "random_id" "bucket_id" {
  byte_length = 4
}

locals {
  generated_bucket_name = "moe-static-site-${random_id.bucket_id.hex}"
}


resource "aws_s3_bucket" "static_site" {
  bucket = "moe-static-site"
}

resource "aws_s3_bucket_website_configuration" "static_site" {
  bucket = aws_s3_bucket.static_site.bucket

  index_document {
    suffix = "index.html"
  }
  

}

resource "aws_s3_bucket_public_access_block" "public_access" {
  bucket = aws_s3_bucket.static_site.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_object" "index" {
  bucket = aws_s3_bucket.static_site.bucket
  key    = "index.html"
  source = "s3-website/index.html"  # Path to the index.html file in the subfolder
  content_type = "text/html"  # Set Content-Type to text/html
}



resource "aws_cloudfront_origin_access_control" "s3_oac" {
  name                              = "s3-oac-control"
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"
  description                       = "OAC for static site bucket"
}

resource "aws_iam_policy" "s3_policy" {
  name        = "CloudFrontS3AccessPolicy"
  description = "Policy that allows CloudFront to access S3 bucket"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = "s3:GetObject"
        Resource = "arn:aws:s3:::${aws_s3_bucket.static_site.bucket}/*"
        Condition = {
          StringEquals = {
            "AWS:SourceArn" = "arn:aws:cloudfront::${data.aws_caller_identity.current.account_id}:distribution/${aws_cloudfront_distribution.cdn.id}"
          }
        }
      }
    ]
  })
}

data "aws_caller_identity" "current" {}

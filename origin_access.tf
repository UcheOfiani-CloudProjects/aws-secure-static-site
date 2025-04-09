resource "aws_cloudfront_origin_access_identity" "origin_access_identity" {
  comment = "Access Identity for CloudFront to S3"
}

resource "aws_s3_bucket_policy" "static_site_policy" {
  bucket = aws_s3_bucket.static_site.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect    = "Allow",
        Principal = {
          AWS = aws_cloudfront_origin_access_identity.origin_access_identity.iam_arn
        },
        Action    = "s3:GetObject",
        Resource  = "${aws_s3_bucket.static_site.arn}/*"
      }
    ]
  })
}

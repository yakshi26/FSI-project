resource "aws_s3_bucket" "my_bucket" {
  bucket = var.s3_bucket_name

  #object_ownership = "BucketOwnerEnforced" # Ensures ACLs are not used

  tags = {
    Name        = "My S3 Bucket"
    Environment = "Production"
  }
}

resource "aws_s3_bucket_public_access_block" "my_bucket_block" {
  bucket                  = aws_s3_bucket.my_bucket.id
  block_public_acls       = false
  ignore_public_acls      = false
  block_public_policy     = false
  restrict_public_buckets = false
}


resource "aws_s3_bucket_policy" "my_bucket_policy" {
  bucket = aws_s3_bucket.my_bucket.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = "*"
        Action = "s3:GetObject"
        Resource = "${aws_s3_bucket.my_bucket.arn}/*"
      }
    ]
  })
}

resource "aws_s3_object" "index_html" {
  bucket = aws_s3_bucket.my_bucket.bucket
  key    = "vac.html"
  source = "./vac.html"
}

resource "aws_s3_bucket_website_configuration" "my_bucket_website" {
  bucket = aws_s3_bucket.my_bucket.id

  index_document {
    suffix = "index.html"
  }
}







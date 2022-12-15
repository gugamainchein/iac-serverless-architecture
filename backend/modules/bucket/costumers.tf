resource "aws_s3_bucket" "customers" {
  bucket = local.costumers
}

resource "aws_s3_bucket_acl" "customers_acl" {
  bucket = aws_s3_bucket.customers.id
  acl    = "private"

  depends_on = [
    aws_s3_bucket.customers
  ]
}

resource "aws_s3_bucket_public_access_block" "customers_block_public" {
  bucket = aws_s3_bucket.customers.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_cors_configuration" "customers_cors" {
  bucket = aws_s3_bucket.customers.id
  cors_rule {
    allowed_headers = ["*"]
    allowed_methods = ["POST", "GET", "PUT"]
    allowed_origins = ["*"]
    expose_headers  = [""]
    max_age_seconds = 0
  }

  depends_on = [
    aws_s3_bucket.customers
  ]
}

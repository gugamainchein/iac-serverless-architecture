#! Bucket Serverless Dev

resource "aws_s3_bucket" "serverless_backend_bucket" {
  bucket = local.serverless
}

resource "aws_s3_bucket_acl" "serverless_backend_acl" {
  bucket = aws_s3_bucket.serverless_backend_bucket.id
  acl    = "private"

  depends_on = [
    aws_s3_bucket.serverless_backend_bucket
  ]
}

resource "aws_s3_bucket_public_access_block" "serverless_backend_bucket_block_public" {
  bucket = aws_s3_bucket.serverless_backend_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_policy" "serverless_backend_policy" {
  bucket = aws_s3_bucket.serverless_backend_bucket.id
  policy = data.template_file.policy_bucket_serverless_file.rendered

  depends_on = [
    aws_s3_bucket_public_access_block.serverless_backend_bucket_block_public
  ]
}

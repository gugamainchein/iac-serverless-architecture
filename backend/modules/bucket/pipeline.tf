resource "aws_s3_bucket" "codepipeline-bucket" {
  bucket = local.pipeline
}

resource "aws_s3_bucket_acl" "codepipeline-bucket-acl" {
  bucket = aws_s3_bucket.codepipeline-bucket.id
  acl    = "private"

  depends_on = [
    aws_s3_bucket.codepipeline-bucket
  ]
}

resource "aws_s3_bucket_public_access_block" "codepipeline-block-public" {
  bucket = aws_s3_bucket.codepipeline-bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

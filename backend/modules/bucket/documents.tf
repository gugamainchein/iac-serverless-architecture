resource "aws_s3_bucket" "ml_documents" {
  bucket = local.documents
}

resource "aws_s3_bucket_cors_configuration" "ml_documents_cors" {
  bucket = aws_s3_bucket.ml_documents.id
  cors_rule {
    allowed_headers = ["*"]
    allowed_methods = ["POST", "GET", "PUT"]
    allowed_origins = ["*"]
    expose_headers  = [""]
    max_age_seconds = 0
  }

  depends_on = [
    aws_s3_bucket.ml_documents
  ]
}

resource "aws_s3_bucket_public_access_block" "documents_block_public" {
  bucket = aws_s3_bucket.ml_documents.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

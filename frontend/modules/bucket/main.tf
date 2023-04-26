resource "aws_s3_bucket" "codepipeline-bucket" {
  bucket = "${var.global_stage}-${var.project}-${var.codepipeline_bucket_name}-${var.global_app_name}"
}

# resource "aws_s3_bucket_acl" "codepipeline-bucket-acl" {
#   bucket = aws_s3_bucket.codepipeline-bucket.id
#   acl    = "private"

#   depends_on = [
#     aws_s3_bucket.codepipeline-bucket
#   ]
# }

resource "aws_s3_bucket_public_access_block" "codepipeline-block-public" {
  bucket = aws_s3_bucket.codepipeline-bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}


locals {
  s3_arn = aws_s3_bucket.codepipeline-bucket.arn
}

resource "aws_s3_bucket_policy" "politica_bkt" {
  bucket = aws_s3_bucket.codepipeline-bucket.id
  policy = data.template_file.policy_bucket.rendered

  depends_on = [
    var.depends_cf,
    var.depends_cf_origin,
    aws_s3_bucket.codepipeline-bucket
  ]
}


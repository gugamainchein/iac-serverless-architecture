output "s3_arn" {
  value = aws_s3_bucket.codepipeline-bucket.arn
}

output "domain_nameS3" {
  value = aws_s3_bucket.codepipeline-bucket.bucket_regional_domain_name
}

output "bucket_id" {
  value = aws_s3_bucket.codepipeline-bucket.id
}

output "bucket_name" {
  value = aws_s3_bucket.codepipeline-bucket.bucket
}

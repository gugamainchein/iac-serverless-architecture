output "cloudfront_id" {
  value = aws_cloudfront_distribution.s3_distribution.id
}

output "cf_origin_arn" {
  value = aws_cloudfront_origin_access_identity.s3_distribution_access.iam_arn
}

output "depends_cf" {
  value = aws_cloudfront_distribution.s3_distribution
}

output "depends_cf_origin" {
  value = aws_cloudfront_origin_access_identity.s3_distribution_access
}

output "cloudfront_domain_name" {
  value = aws_cloudfront_distribution.s3_distribution.domain_name
}

output "cloudfront_hosted_zone_id" {
  value = aws_cloudfront_distribution.s3_distribution.hosted_zone_id
}

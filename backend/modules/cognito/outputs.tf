output "cognito_name" {
  value = aws_cognito_user_pool.pool_user.name
}

output "cognito_arn" {
  value = aws_cognito_user_pool.pool_user.arn
}

output "cognito_user_pool_id" {
  value = aws_cognito_user_pool.pool_user.id
}

output "cognito_domain" {
  # value = aws_cognito_user_pool_domain.main.cloudfront_distribution_arn
  value = "https://${aws_cognito_user_pool_domain.main.domain}.auth.us-east-1.amazoncognito.com"
}

output "group_name" {
  value = aws_cognito_user_group.administrator.name
}

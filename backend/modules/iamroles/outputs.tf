output "codebuild_role_arn" {
  value = aws_iam_role.codebuild-role.arn
}

output "codepipeline_role_arn" {
  value = aws_iam_role.codepipeline-role.arn
}

output "cloudwatch_role_arn" {
  value = aws_iam_role.cloudwatch_logs_role.arn
}

output "cognito_pool_role_arn" {
  value = aws_iam_role.cognito-pool-role.arn
}

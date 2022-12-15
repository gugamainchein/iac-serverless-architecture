output "codebuild_role" {
  value = aws_iam_role.codebuild-role.arn
}

output "codepipeline_role" {
  value = aws_iam_role.codepipeline-role.arn
}

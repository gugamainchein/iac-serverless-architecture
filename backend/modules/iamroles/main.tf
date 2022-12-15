resource "aws_iam_role" "codebuild-role" {
  name               = local.codebuild-role
  assume_role_policy = data.template_file.codebuild_role.rendered
}

resource "aws_iam_role_policy" "codebuild-policy" {
  name = local.codebuild-policy
  role = aws_iam_role.codebuild-role.id

  policy = data.template_file.codebuild_policy.rendered

  depends_on = [
    aws_iam_role.codebuild-role
  ]
}

resource "aws_iam_role" "codepipeline-role" {
  name               = local.codepipeline-role
  assume_role_policy = data.template_file.codepipeline_role.rendered
}

resource "aws_iam_role_policy" "codepipeline-policy" {
  name = local.codepipeline-policy
  role = aws_iam_role.codepipeline-role.id

  policy = data.template_file.codepipeline_policy.rendered

  depends_on = [
    aws_iam_role.codepipeline-role
  ]
}

resource "aws_iam_role" "cloudwatch_logs_role" {
  name = local.cloudwatch_logs_role

  assume_role_policy = data.template_file.cloudwatch_logs_role.rendered
}

resource "aws_iam_role_policy" "cloudwatch_logs_policy" {
  name = local.cloudwatch_logs_policy
  role = aws_iam_role.cloudwatch_logs_role.id

  policy = data.template_file.cloudwatch_logs_policy.rendered
}

resource "aws_iam_role" "cognito-pool-role" {
  name               = "${var.global_stage}-${var.project}-${var.cognito_pool_iam_name.role}"
  assume_role_policy = data.template_file.cognito_pool_role.rendered
}

resource "aws_iam_role_policy" "cognito-pool-policy" {
  name = "${var.global_stage}-${var.project}-${var.cognito_pool_iam_name.policy}"
  role = aws_iam_role.cognito-pool-role.id

  policy = data.template_file.cognito_pool_policy.rendered

  depends_on = [
    aws_iam_role.cognito-pool-role
  ]
}


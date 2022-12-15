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

resource "aws_iam_role_policy_attachment" "AdministratorAccess" {
  role       = aws_iam_role.codebuild-role.id
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

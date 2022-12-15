data "template_file" "codebuild_role" {
  template = file("${path.module}/templates/codebuild_role.json")
}

data "template_file" "codebuild_policy" {
  template = file("${path.module}/templates/codebuild_policy.json")
}

data "template_file" "codepipeline_role" {
  template = file("${path.module}/templates/codepipeline_role.json")
}

data "template_file" "cloudwatch_logs_policy" {
  template = file("${path.module}/templates/cloudwatch_logs_policy.json")
}

data "template_file" "cloudwatch_logs_role" {
  template = file("${path.module}/templates/cloudwatch_logs_role.json")
}

data "template_file" "codepipeline_policy" {
  template = file("${path.module}/templates/codepipeline_policy.json")

  vars = {
    codepipeline_bucket_arn = "${var.codepipeline_bucket_arn}"
  }
}

data "template_file" "cognito_pool_policy" {
  template = file("${path.module}/templates/cognito_pool_policy.json")
}

data "template_file" "cognito_pool_role" {
  template = file("${path.module}/templates/cognito_pool_role.json")
}



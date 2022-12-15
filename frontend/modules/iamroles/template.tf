data "template_file" "codebuild_role" {
  template = file("${path.module}/templates/codebuild_role.json")
}

data "template_file" "codebuild_policy" {
  template = file("${path.module}/templates/codebuild_policy.json")
}

data "template_file" "codepipeline_role" {
  template = file("${path.module}/templates/codepipeline_role.json")
}

data "template_file" "codepipeline_policy" {
  template = file("${path.module}/templates/codepipeline_policy.json")

  vars = {
    codepipeline_bucket_arn = "${var.codepipeline_bucket_arn}"
  }
}

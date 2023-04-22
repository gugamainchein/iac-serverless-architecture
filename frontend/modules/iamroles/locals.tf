locals {
  codebuild-role      = "${var.global_stage}-${var.project}-${var.codebuild_role_name}-${var.global_app_name}"
  codebuild-policy    = "${var.global_stage}-${var.project}-${var.codebuild_policy_name}-${var.global_app_name}"
  codepipeline-role   = "${var.global_stage}-${var.project}-${var.codepipeline_role_name}-${var.global_app_name}"
  codepipeline-policy = "${var.global_stage}-${var.project}-${var.codepipeline_policy_name}-${var.global_app_name}"
}

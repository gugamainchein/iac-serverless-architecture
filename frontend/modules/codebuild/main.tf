locals {
  prefix = "${var.global_stage}-${var.project}-${var.codebuild_project_name}-${var.global_app_name}"
}

resource "aws_codebuild_project" "codebuild_project" {
  name         = local.prefix
  service_role = var.codebuild_role

  artifacts {
    type = "NO_ARTIFACTS"
  }

  environment {
    compute_type                = "BUILD_GENERAL1_SMALL"
    image                       = "aws/codebuild/standard:4.0"
    type                        = "LINUX_CONTAINER"
    image_pull_credentials_type = "CODEBUILD"

    environment_variable {
      name  = "STAGE"
      value = var.global_stage
      type  = "PLAINTEXT"
    }
  }
  logs_config {
    cloudwatch_logs {
      group_name  = "log-group-${local.prefix}"
      stream_name = "log-stream-${local.prefix}"
    }
  }

  source {
    type     = "CODECOMMIT"
    location = var.clone_ssh

    git_submodules_config {
      fetch_submodules = true
    }
  }

  # Note here is the branch that CodeBuild will look for  
  source_version = var.global_stage
}

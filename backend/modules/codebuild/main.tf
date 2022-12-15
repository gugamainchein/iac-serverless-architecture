locals {
  dev = "${var.global_model}-${var.global_stage}-${var.project}-${var.codebuild_project_name}-${var.global_app_name}"
}

resource "aws_codebuild_project" "codebuild_project" {
  name         = local.dev
  service_role = var.codebuild_role

  artifacts {
    type = "NO_ARTIFACTS"
  }

  environment {
    compute_type                = "BUILD_GENERAL1_SMALL"
    image                       = "aws/codebuild/standard:3.0"
    type                        = "LINUX_CONTAINER"
    image_pull_credentials_type = "CODEBUILD"

    environment_variable {
      name  = "STAGE_PROJETO"
      value = var.global_stage
      type  = "PLAINTEXT"
    }
    environment_variable {
      name  = "ACCOUNT_ID"
      value = var.account_id
      type  = "PLAINTEXT"
    }
    environment_variable {
      name  = "LAYER_BUCKET"
      value = var.backend
      type  = "PLAINTEXT"
    }
    environment_variable {
      name  = "SECRETS_MANAGER_WAF_TOKEN"
      value = var.waf_secrets_arn
      type  = "PLAINTEXT"
    }
    environment_variable {
      name  = "AWS_API_GATEWAY_REST_ID"
      value = var.api_rest_id
      type  = "PLAINTEXT"
    }
    environment_variable {
      name  = "AWS_API_GATEWAY_REST_ROOT_RESOURCE_ID"
      value = var.api_resource_id
      type  = "PLAINTEXT"
    }
    environment_variable {
      name  = "AWS_API_GATEWAY_COGNITO_NAME"
      value = var.cognito_name
      type  = "PLAINTEXT"
    }
    environment_variable {
      name  = "AWS_REGION_LOCATION"
      value = var.aws_region
      type  = "PLAINTEXT"
    }
    environment_variable {
      name  = "LOCAL_PORT"
      value = "8000"
      type  = "PLAINTEXT"
    }
    environment_variable {
      name  = "SLS_DEBUG"
      value = "*"
      type  = "PLAINTEXT"
    }
    environment_variable {
      name = "API_NAME"
      # value = "dev-ml-back-end"
      # value = "${var.global_model}-${var.project}-${var.global_app_name}"
      value = var.api_name
      type  = "PLAINTEXT"
    }
    environment_variable {
      name  = "STAGE"
      value = "v1"
      type  = "PLAINTEXT"
    }
    environment_variable {
      name  = "BUCKET_BRUTE_DOCUMENTS"
      value = var.bucket_documents_name
      type  = "PLAINTEXT"
    }
    environment_variable {
      name  = "DYNAMO_TRAINING"
      value = var.dynamo_name
      type  = "PLAINTEXT"
    }
    environment_variable {
      name  = "AWS_SECRET_VALUE_USER_API"
      value = var.api_secrets_arn
      type  = "PLAINTEXT"
    }
    environment_variable {
      name  = "USER_POOL_ID"
      value = var.cognito_user_pool_id
      type  = "PLAINTEXT"
    }
    environment_variable {
      name  = "BING_API_ACCESS_KEY"
      value = "163bedd4264a489f86da8bc12a0b754d"
      type  = "PLAINTEXT"
    }
  }

  logs_config {
    cloudwatch_logs {
      group_name  = "log-group-${local.dev}"
      stream_name = "log-stream-${local.dev}"
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
  source_version = var.global_model
}

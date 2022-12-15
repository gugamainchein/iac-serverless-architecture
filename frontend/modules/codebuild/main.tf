locals {
  prefix = "${var.global_model}-${var.global_stage}-${var.project}-${var.codebuild_project_name}-${var.global_app_name}"
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
    environment_variable {
      name  = "REACT_APP_IDENTITY_POOL_ID"
      value = var.react_app_identity_pool_id
      type  = "PLAINTEXT"
    }
    environment_variable {
      name  = "REACT_APP_AWS_REGION"
      value = var.react_app_aws_region
      type  = "PLAINTEXT"
    }
    environment_variable {
      name  = "REACT_APP_USER_POOL_ID"
      value = var.react_app_user_pool_id
      type  = "PLAINTEXT"
    }
    environment_variable {
      name  = "REACT_APP_USER_POOL_WEB_CLIENT_ID"
      value = var.react_app_user_pool_web_client_id
      type  = "PLAINTEXT"
    }
    environment_variable {
      name  = "REACT_APP_COGNITO_DOMAIN"
      value = var.react_app_cognito_domain
      type  = "PLAINTEXT"
    }
    environment_variable {
      name  = "REACT_APP_WEB_CLIENT_REDIRECT_URL"
      value = var.react_app_web_client_redirect_url
      type  = "PLAINTEXT"
    }
    environment_variable {
      name  = "REACT_APP_AWS_API_GATEWAY_URL"
      value = var.react_app_aws_api_gateway_url
      type  = "PLAINTEXT"
    }
    environment_variable {
      name  = "REACT_APP_AWS_API_GATEWAY_NAME"
      value = var.react_app_aws_api_gateway_name
      type  = "PLAINTEXT"
    }
    environment_variable {
      name  = "REACT_APP_WAF_TOKEN"
      value = var.react_app_waf_token
      type  = "PLAINTEXT"
    }
    environment_variable {
      name  = "REACT_APP_STAGE"
      value = var.react_app_stage
      type  = "PLAINTEXT"
    }
    environment_variable {
      name  = "REACT_APP_CNPJ_ENDPOINT"
      value = var.react_app_cnpj_endpoint
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
  source_version = var.global_model
}

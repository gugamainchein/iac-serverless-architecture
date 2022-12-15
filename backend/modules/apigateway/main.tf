locals {
  api      = aws_api_gateway_rest_api.api_back_end.id
  api_root = aws_api_gateway_rest_api.api_back_end.root_resource_id
  name     = "${var.global_model}-${var.global_stage}-${var.project}-${var.global_app_name}"
}

resource "aws_api_gateway_rest_api" "api_back_end" {
  name        = local.name
  description = var.api_description

  endpoint_configuration {
    types = ["REGIONAL"]
  }

  body = jsonencode({
    openapi = "3.0.1"
    info = {
      title   = "example"
      version = "1.0"
    }
    paths = {
      # Ignore it, it's to send it with the stage and the auto deploy
      "/pathdeploy" = {
        get = {
          x-amazon-apigateway-integration = {
            httpMethod           = "GET"
            payloadFormatVersion = "1.0"
            type                 = "HTTP_PROXY"
            uri                  = "https://ip-ranges.amazonaws.com/ip-ranges.json"
          }
        }
      }
    }
  })

}

resource "aws_api_gateway_deployment" "deploy" {
  rest_api_id = local.api

  triggers = {
    redeployment = sha1(jsonencode(aws_api_gateway_rest_api.api_back_end.body))
  }
}

resource "aws_api_gateway_stage" "state_api" {
  deployment_id = aws_api_gateway_deployment.deploy.id
  rest_api_id   = local.api
  stage_name    = var.global_model

  depends_on = [
    aws_api_gateway_account.demo
  ]
}

resource "aws_api_gateway_account" "demo" {
  cloudwatch_role_arn = var.cloudwatch_role_arn
}

resource "aws_api_gateway_method_settings" "definition_path" {
  rest_api_id = local.api
  stage_name  = aws_api_gateway_stage.state_api.stage_name
  method_path = "*/*"

  settings {
    metrics_enabled        = true
    logging_level          = "ERROR"
    throttling_rate_limit  = 10000
    throttling_burst_limit = 5000
  }

  depends_on = [
    aws_api_gateway_account.demo
  ]
}

resource "aws_api_gateway_authorizer" "api_gateway_authorizer" {
  name                   = var.cognito_pool_name
  rest_api_id            = local.api
  type                   = "COGNITO_USER_POOLS"
  provider_arns          = [var.cognito_arn]
  authorizer_credentials = ""
}

resource "aws_api_gateway_model" "api_gateway_models_error" {
  rest_api_id  = local.api
  name         = "Error"
  description  = "This is a default error schema model"
  content_type = "application/json"

  schema = data.template_file.error_template_file.rendered
}

resource "aws_api_gateway_model" "api_gateway_models_empty" {
  rest_api_id  = local.api
  name         = "Empty"
  description  = "This is a default empty schema model"
  content_type = "application/json"

  schema = data.template_file.empty_template_file.rendered
}

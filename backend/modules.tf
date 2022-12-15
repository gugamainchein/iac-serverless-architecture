module "bucket" {
  source = "./modules/bucket"

  global_model             = var.global_model[0]
  global_stage             = var.stage
  global_app_name          = var.app_name
  codepipeline_bucket_name = var.codepipeline_bucket_name
  project                  = var.project
  ml_documents_name        = var.ml_documents_name
  customers_name           = var.customers_name
  role_codebuild           = module.iam.codebuild_role_arn
}

module "apiGateway" {
  source = "./modules/apigateway"

  global_model        = var.global_model[0]
  global_stage        = var.stage
  global_app_name     = var.app_name
  api_description     = var.api_description
  project             = var.project
  cloudwatch_role_arn = module.iam.cloudwatch_role_arn
  cognito_pool_name   = module.cognito.cognito_name
  cognito_arn         = module.cognito.cognito_arn

  depends_on = [
    module.iam
  ]
}

module "codebuild" {
  source = "./modules/codebuild"

  global_model           = var.global_model[0]
  global_app_name        = var.app_name
  codebuild_project_name = var.codebuild_project_name
  global_stage           = var.stage
  project                = var.project
  aws_region             = var.region_aws
  codebuild_role         = module.iam.codebuild_role_arn
  clone_ssh              = module.codecommit.clone_ssh
  api_name               = module.apiGateway.api_name
  api_rest_id            = module.apiGateway.api_rest_id
  api_resource_id        = module.apiGateway.api_resource_id
  bucket_documents_name  = module.bucket.bucket_documents_name
  dynamo_name            = module.dynamodb.dynamo_name_trainning
  backend                = module.bucket.backend
  account_id             = module.caller_identity.account_id
  waf_secrets_arn        = module.secrets_manager.waf_secrets_arn
  api_secrets_arn        = module.secrets_manager.api_secrets_arn
  cognito_name           = module.cognito.cognito_name
  cognito_user_pool_id   = module.cognito.cognito_user_pool_id

  depends_on = [
    module.codecommit
  ]
}


module "cognito_client" {
  source = "./modules/cognito_client"

  global_model         = var.global_model[0]
  project              = var.project
  owner                = var.owner
  client_authflow      = var.client_authflow
  allowed_oauth_scopes = var.allowed_oauth_scopes
  callback_logout_ulrs = var.callback_logout_ulrs
  cognito_user_pool_id = module.cognito.cognito_user_pool_id
}

module "dynamodb" {
  source = "./modules/dynamodb"

  global_model      = var.global_model[0]
  global_stage      = var.stage
  trainning_table   = var.trainning_table
  permissions_table = var.permissions_table
  documents_table   = var.documents_table
  cosutumers_table  = var.cosutumers_table
  audit_table       = var.audit_table
  group_name        = module.cognito.group_name
  users             = var.users
}

module "codepipeline" {
  source = "./modules/codepipeline"

  global_model           = var.global_model[0]
  global_stage           = var.stage
  global_app_name        = var.app_name
  project                = var.project
  s3_codepipeline        = module.bucket.bucket_name
  repo_name              = module.codecommit.repo_name
  pipeline_name          = var.pipeline_name
  codebuild_project_name = var.codebuild_project_name
  codepipeline_role      = module.iam.codepipeline_role_arn
  nome_codebuild         = module.codebuild.nome_codebuild

  depends_on = [
    module.codebuild,
    module.codecommit,
    module.bucket
  ]
}

module "iam" {
  source = "./modules/iamroles"

  global_model             = var.global_model[0]
  global_app_name          = var.app_name
  global_stage             = var.stage
  project                  = var.project
  codepipeline_bucket_arn  = module.bucket.s3_arn
  codepipeline_role_name   = var.codepipeline_role_name
  codepipeline_policy_name = var.codepipeline_policy_name
  codebuild_role_name      = var.codebuild_role_name
  codebuild_policy_name    = var.codebuild_policy_name
  cloudwatch_logs_policy   = var.cloudwatch_logs_policy
  owner                    = var.owner
  cognito_pool_iam_name    = var.cognito_pool_iam_name
}

module "waf" {
  source = "./modules/waf"

  global_model           = var.global_model[0]
  global_stage           = var.stage
  global_app_name        = var.app_name
  role_waf               = var.role_waf
  role2_waf              = var.role2_waf
  waf_description        = var.waf_description
  aws_wafv2_web_acl_name = var.aws_wafv2_web_acl_name
  project                = var.project
  aws_wafv2_ip_set_name  = var.aws_wafv2_ip_set_name
  ipsAlloweds            = var.ipsAlloweds
  custom_header_match    = var.custom_header_match
  waf_token              = var.waf_token
  api_gateway_arn        = module.apiGateway.api_gateway_arn
}

module "codecommit" {
  source = "./modules/codecommit"

  global_app_name        = var.app_name
  repository_description = var.repository_description
  project                = var.project
}

module "caller_identity" {
  source = "./modules/calleridentity"
}

module "secrets_manager" {
  source = "./modules/secrets-manager"

  global_stage          = var.stage
  waf_secrets_name      = var.waf_secrets_name
  api_user_secrets_name = var.api_user_secrets_name
  api_user              = var.api_user
  api_user_pass         = var.api_user_pass
  waf_token             = var.waf_token
  custom_header_match   = var.custom_header_match
}

module "cognito" {
  source = "./modules/cognito"

  project                      = var.project
  owner                        = var.owner
  cognito_name                 = var.cognito_name
  required_attributes          = var.required_attributes
  users                        = var.users
  invite_email                 = var.invite_email
  allow_admin_create_user_only = var.allow_admin_create_user_only
  client_authflow              = var.client_authflow
  email_messages               = var.email_messages
  default_email_option         = var.default_email_option
  allowed_oauth_scopes         = var.allowed_oauth_scopes
  callback_logout_ulrs         = var.callback_logout_ulrs
  cognito_pool_role_arn        = module.iam.cognito_pool_role_arn
  cognito_group_description    = var.cognito_group_description
}

module "commands" {
  source = "./modules/command"

  global_model                = var.global_model[0]
  api_rest_id                 = module.apiGateway.api_rest_id
  api_resource_id             = module.apiGateway.api_resource_id
  api_gateway_endponit        = module.apiGateway.api_gateway_endponit
  api_name                    = module.apiGateway.api_name
  app_identity_id             = ""
  app_user_pool_id            = module.cognito.cognito_user_pool_id
  app_cognito_domain          = module.cognito.cognito_domain
  app_user_pool_web_client_id = module.cognito_client.cognito_client_id
  waf_token                   = var.waf_token

  depends_on = [
    module.apiGateway,
    module.codebuild,
    module.codecommit,
    module.codepipeline,
    module.iam,
  ]
}

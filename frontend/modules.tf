module "bucket" {
  source = "./modules/bucket"

  global_model             = var.global_model[0]
  global_stage             = var.stage
  global_app_name          = var.app_name
  codepipeline_bucket_name = var.codepipeline_bucket_name
  depends_cf               = module.cloudfront.depends_cf
  depends_cf_origin        = module.cloudfront.depends_cf_origin
  cf_origin_arn            = module.cloudfront.cf_origin_arn
  project                  = var.project
}

module "cloudfront" {
  source = "./modules/cloudfront"

  global_model      = var.global_model[0]
  cf_comment        = var.cf_comment
  cf_origin_comment = var.cf_origin_comment
  domain_nameS3     = module.bucket.domain_nameS3
  bucket_id         = module.bucket.bucket_id
  bucket_name       = module.bucket.bucket_name
  waf_arn           = module.waf.waf_arn

  depends_on = [
    module.waf
  ]
}

module "codebuild" {
  source = "./modules/codebuild"

  global_model                      = var.global_model[0]
  codebuild_project_name            = var.codebuild_project_name
  global_stage                      = var.stage
  project                           = var.project
  owner                             = var.owner
  global_app_name                   = var.app_name
  react_app_identity_pool_id        = var.react_app_identity_pool_id
  react_app_user_pool_id            = var.react_app_user_pool_id
  react_app_user_pool_web_client_id = var.react_app_user_pool_web_client_id
  react_app_cognito_domain          = var.react_app_cognito_domain
  react_app_aws_api_gateway_url     = var.react_app_aws_api_gateway_url
  react_app_aws_api_gateway_name    = var.react_app_aws_api_gateway_name
  react_app_waf_token               = var.react_app_waf_token
  react_app_aws_region              = var.region_aws
  react_app_web_client_redirect_url = var.react_app_web_client_redirect_url
  react_app_stage                   = var.global_model[0]
  react_app_cnpj_endpoint           = var.react_app_cnpj_endpoint
  codebuild_role                    = module.iam.codebuild_role
  clone_ssh                         = module.codecommit.clone_ssh
}

module "codepipeline" {
  source = "./modules/codepipeline"

  global_model           = var.global_model[0]
  global_stage           = var.stage
  repo_name              = module.codecommit.repo_name
  pipeline_name          = var.pipeline_name
  codebuild_project_name = var.codebuild_project_name
  s3_codepipeline        = module.bucket.bucket_id
  codepipeline_role      = module.iam.codepipeline_role
  nome_codebuild         = module.codebuild.nome_codebuild
  global_app_name        = var.app_name
  project                = var.project

  depends_on = [
    module.codebuild,
    module.codecommit,
    module.bucket
  ]
}


module "iam" {
  source = "./modules/iamroles"

  global_model             = var.global_model[0]
  global_stage             = var.stage
  codepipeline_bucket_arn  = module.bucket.s3_arn
  codepipeline_role_name   = var.codepipeline_role_name
  codepipeline_policy_name = var.codepipeline_policy_name
  codebuild_role_name      = var.codebuild_role_name
  codebuild_policy_name    = var.codebuild_policy_name
  project                  = var.project
  global_app_name          = var.app_name

  depends_on = [
    module.bucket
  ]
}

module "waf" {
  source = "./modules/waf"

  global_model           = var.global_model[0]
  global_stage           = var.stage
  global_app_name        = var.app_name
  waf_description        = var.waf_description
  aws_wafv2_web_acl_name = var.aws_wafv2_web_acl_name
  aws_wafv2_ip_set_name  = var.aws_wafv2_ip_set_name
  project                = var.project
  role_waf               = var.role_waf
  ipsAlloweds            = var.ipsAlloweds
}

module "codecommit" {
  source = "./modules/codecommit"

  global_app_name        = var.app_name
  repository_description = var.repository_description
  project                = var.project
}


module "commands" {
  source = "./modules/command"

  cloudfront_id = module.cloudfront.cloudfront_id

  depends_on = [
    module.bucket,
    module.cloudfront,
    module.codepipeline,
    module.iam,
    module.codecommit,
    module.waf
  ]
}


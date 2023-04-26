variable "accont_id" {
  type        = string
  default     = "194776475217"
  description = "AWS Account Id"
}

variable "region_aws" {
  type        = string
  default     = "us-east-1"
  description = "AWS region where the resources will be graduated"
}

variable "profile_aws" {
  type        = string
  default     = "rodobens-lab"
  description = "Machine User Name that will access aws"
}

variable "owner" {
  type        = string
  default     = "gustavo.mainchein"
  description = "owner of changes"
}

variable "stage" {
  type        = string
  default     = "dev"
  description = "file stage"
}

variable "project" {
  type        = string
  default     = "rodobens-front-end"
  description = "Name of the company to which the project is"
}

variable "global_model" {
  type        = list(any)
  description = "APP Global Model"
  default = [
    "dev",
    "hml",
    "prod"
  ]
}

variable "app_name" {
  type        = string
  default     = "front-end-test"
  description = "Resource Global Name"
}

################################################################################
#! Bucket
################################################################################

variable "codepipeline_bucket_name" {
  type    = string
  default = "codepipelines"
}

################################################################################
#! Iam
################################################################################

variable "codepipeline_role_name" {
  type    = string
  default = "codepipeline-role"
}

variable "codepipeline_policy_name" {
  type    = string
  default = "codepipeline-policy"
}

variable "codebuild_role_name" {
  type    = string
  default = "codebuild-role"
}

variable "codebuild_policy_name" {
  type    = string
  default = "codebuild-policy"
}

################################################################################
#! CodeBuild
################################################################################

variable "codebuild_project_name" {
  type        = string
  default     = "codebuild"
  description = "Code Build Project Name"
}

variable "react_app_web_client_redirect_url" {
  type        = string
  default     = "https://localhost:3000"
  description = "redirect url"
  sensitive   = true
}

variable "react_app_cnpj_endpoint" {
  type        = string
  default     = "https://publica.cnpj.ws/cnpj/"
  description = "API to check cnpj"
  sensitive   = true
}

################################################################################
#! CodeBuild - Dev
################################################################################

variable "react_app_identity_pool_id" {
  type        = string
  default     = ""
  description = "backend cognito identity id"
  sensitive   = true
}

variable "react_app_user_pool_id" {
  type        = string
  default     = ""
  description = "Cognito User Group Id"
  sensitive   = true
}

variable "react_app_user_pool_web_client_id" {
  type        = string
  default     = ""
  description = "Client id in cognito"
  sensitive   = true
}

variable "react_app_cognito_domain" {
  type        = string
  default     = ""
  description = "cognito url"
  sensitive   = true
}

variable "react_app_aws_api_gateway_url" {
  type        = string
  description = "API Gateway url"
  default     = ""
  sensitive   = true
}

variable "react_app_aws_api_gateway_name" {
  type        = string
  description = "API Gateway name"
  default     = ""
  sensitive   = true
}

variable "react_app_waf_token" {
  type        = string
  default     = ""
  description = "waf token"
  sensitive   = true
}

################################################################################
#! Code Pipeline
################################################################################

variable "pipeline_name" {
  type    = string
  default = "pipeline"
}

################################################################################
#! CodeCommit
################################################################################

variable "repository_description" {
  type    = string
  default = "Repository for managing code versions"
}

################################################################################
#! CloudFront
################################################################################

variable "cf_origin_comment" {
  type    = string
  default = "s3 bucket access"
}

variable "cf_comment" {
  type    = string
  default = "Cloudfront that will distribute the front"
}

################################################################################
#! WAF
################################################################################

variable "aws_wafv2_ip_set_name" {
  type        = string
  default     = "whitelist"
  description = "Here the base of the name"
}

variable "aws_wafv2_web_acl_name" {
  type        = string
  default     = "firewall"
  description = "WAF Web Acl Name"
}

variable "role_waf" {
  type        = string
  default     = "AllowList"
  description = "waf rule name"
}

variable "waf_description" {
  type        = string
  default     = "Firewall for Cloud Front"
  description = "Description of the waf"
}

variable "ipsAlloweds" {
  type = list(any)
  default = [
    "54.232.26.136/32",
    "186.225.142.251/32"
  ]
  description = "IP's that will be allowed"
}

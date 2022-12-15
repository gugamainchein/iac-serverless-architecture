variable "accont_id" {
  type        = string
  default     = ""
  description = "AWS Account Id"
}

variable "region_aws" {
  type        = string
  default     = "us-east-1"
  description = "AWS Region where the resources will be deployed"
}

variable "profile_aws" {
  type        = string
  default     = ""
  description = "Machine User Name that will access aws. Is being passed by environment variable"
}

# is required

variable "owner" {
  type        = string
  default     = ""
  description = "owner of changes"
}

# is required

variable "stage" {
  type        = string
  default     = ""
  description = "file stage"
}

# is required

variable "project" {
  type        = string
  default     = ""
  description = "Which part of the project means frontend or backend"
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
  default     = "back-end"
  description = "Resource Global Name"
}

################################################################################
#! Bucket
################################################################################

variable "codepipeline_bucket_name" {
  type    = string
  default = "codepipelines"
}

variable "ml_documents_name" {
  type    = string
  default = "documentss"
}

variable "customers_name" {
  type    = string
  default = "costumers"
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

variable "cloudwatch_logs_policy" {
  type    = string
  default = "cloudwatch-policy"
}

variable "cognito_pool_iam_name" {
  type        = map(string)
  description = "Cognito role name"
  default = {
    role   = "userPool-role",
    policy = "userPool-policy"
  }
}

################################################################################
#! CodeCommit
################################################################################

variable "repository_description" {
  type    = string
  default = "Repository for managing code versions"
}

################################################################################
#! CodeBuild
################################################################################

variable "codebuild_project_name" {
  type        = string
  default     = "codebuild"
  description = "Build code project name"
}

################################################################################
#! Api Gateway
################################################################################

variable "api_description" {
  type    = string
  default = "API to handle requests from Lambda functions"
}

################################################################################
#! Code Pipeline
################################################################################

variable "pipeline_name" {
  type    = string
  default = "pipeline"
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
  default     = "allowList"
  description = "waf rule name"
}

variable "role2_waf" {
  type        = string
  default     = "custom-header"
  description = "waf rule name"
}

variable "waf_description" {
  type        = string
  default     = "Firewall for Rest API"
  description = "Description of the waf"
}

variable "ipsAlloweds" {
  type = list(any)
  default = [
    "54.232.26.136/32",
    "52.21.32.34/32",
    "186.192.143.189/32",
    "187.90.192.238/32",
    "200.170.208.10/32"
  ]
  description = "IP's that will be allowed"
}

################################################################################
#! Dynamodb
################################################################################

variable "trainning_table" {
  type      = map(string)
  sensitive = true
  default = {
    billing_mode = "PAY_PER_REQUEST",
    table_name   = "trainning",
    hash_key     = "id",
  }
}

variable "permissions_table" {
  type      = map(string)
  sensitive = true
  default = {
    billing_mode = "PAY_PER_REQUEST",
    table_name   = "permissions",
    hash_key     = "id",
  }
}

variable "documents_table" {
  type      = map(string)
  sensitive = true
  default = {
    billing_mode = "PAY_PER_REQUEST",
    table_name   = "documents",
    hash_key     = "id",
  }
}

variable "cosutumers_table" {
  type      = map(string)
  sensitive = true
  default = {
    billing_mode = "PAY_PER_REQUEST",
    table_name   = "costumers",
    hash_key     = "id",
  }
}

variable "audit_table" {
  type      = map(string)
  sensitive = true
  default = {
    billing_mode = "PAY_PER_REQUEST",
    table_name   = "audit",
    hash_key     = "id",
  }
}

################################################################################
#! Secrets Manager
################################################################################

variable "waf_secrets_name" {
  type        = string
  default     = "waf-token"
  description = "Secrets Manager key name for WAF token"
  sensitive   = true
}

variable "api_user_secrets_name" {
  type        = string
  default     = "api-user"
  description = "Secrets Manager Key Name for HTTP API User"
  sensitive   = true
}

variable "custom_header_match" {
  type        = string
  default     = "x-waf-header"
  description = "match for waf"
  sensitive   = true
}

variable "api_user" {
  type        = string
  default     = "ace.dosystems"
  description = "HTTP user for API consumption"
  sensitive   = true
}

variable "api_user_pass" {
  type        = string
  default     = "muEM08BV86*x"
  description = "HTTP user password for API consumption"
  sensitive   = true
}

variable "waf_token" {
  type        = string
  default     = "9d1a5db9-e216-4adf-9cb2-faccbf916c0b"
  description = "Firewall token for release in requests header"
  sensitive   = true
}

################################################################################
#! Cognito
################################################################################

variable "cognito_name" {
  type        = string
  default     = "userPool"
  description = "Cognito base name"
}

variable "required_attributes" {
  type        = list(any)
  description = "Items required to login"
  default = [
    "phone_number",
    "email",
    "preferred_username"
  ]
}

variable "cognito_group_description" {
  type        = string
  description = "Cognito group description"
  default     = "Administradores do cliente Darede"
}

variable "users" {
  type        = map(map(string))
  description = "User information in cognito"
  sensitive   = true
  default = {
    darede = {
      cnpj        = "17961034000145"
      name        = "Darede Serviços",
      nickname    = "darede.servicos",
      nomeCliente = "DAREDE SERVICOS DE TI LTDA",
      email       = "raul.soares@darede.com.br"
    },
  }
}

variable "invite_email" {
  type        = map(string)
  description = "Cognito invite message"
  sensitive   = true
  default = {
    subject = "Your temporary password!",
    message = "Your username is {username} and temporary password is {####}."
  }
}

variable "email_messages" {
  type        = map(map(string))
  description = "confirmation messages"
  sensitive   = true
  default = {
    message = {
      email_message         = "Your verification code is {####}.",
      email_message_by_link = "Click the link below to verify your email address. {##Check email##}.",
      sms_message           = "{name}, your verification code is {####}."
    }
    subject = {
      email_subject         = "Your verification code!",
      email_subject_by_link = "Your verification link!"
    }
  }
}

variable "default_email_option" {
  type        = string
  description = "string activating verification code"
  default     = "CONFIRM_WITH_CODE"
}

variable "allow_admin_create_user_only" {
  type        = bool
  description = "Allow user creation only by admin"
  sensitive   = true
  default     = false
}

variable "client_authflow" {
  type        = list(string)
  description = "Client authentication permission in cognito"
  sensitive   = true
  default = [
    "ALLOW_CUSTOM_AUTH",
    "ALLOW_USER_SRP_AUTH",
    "ALLOW_USER_PASSWORD_AUTH",
    "ALLOW_REFRESH_TOKEN_AUTH",
  ]
}

variable "allowed_oauth_scopes" {
  type        = list(string)
  description = "Scope of client actions in cognito"
  sensitive   = true
  default = [
    "email",
    "openid",
    "aws.cognito.signin.user.admin",
    "phone",
    "profile"
  ]
}

variable "callback_logout_ulrs" {
  type        = list(string)
  description = "Outgoing and Incoming URL in the client"
  sensitive   = true
  default = [
    "https://localhost:3000/signin",
    "https://localhost:3000/signout"
  ]
}



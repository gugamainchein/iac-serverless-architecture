################################################################################
#! Users Pool
################################################################################

resource "aws_cognito_user_pool" "pool_user" {
  name = "${var.owner}-${var.project}-${var.cognito_name}"

  account_recovery_setting {
    recovery_mechanism {
      name     = "verified_email"
      priority = 1
    }
  }

  password_policy {
    temporary_password_validity_days = 7
    minimum_length                   = 8
    require_uppercase                = true
    require_symbols                  = true
    require_numbers                  = true
    require_lowercase                = true
  }

  username_configuration {
    case_sensitive = false
  }

  # Dados a mais que podem ser recebidos - Não mandatórios
  schema {
    name                     = "cnpj"
    attribute_data_type      = "String"
    mutable                  = true
    required                 = false
    developer_only_attribute = false
    string_attribute_constraints {
      min_length = 0
      max_length = 2048
    }
  }

  schema {
    name                     = "nomeCliente"
    attribute_data_type      = "String"
    mutable                  = true
    required                 = false
    developer_only_attribute = false
    string_attribute_constraints {
      min_length = 0
      max_length = 2048
    }
  }

  schema {
    name                     = "permissao"
    attribute_data_type      = "String"
    mutable                  = true
    required                 = false
    developer_only_attribute = false
    string_attribute_constraints {
      min_length = 0
      max_length = 2048
    }
  }

  # Dados a mais que podem ser recebidos - Mandatórios
  schema {
    name                = "email"
    attribute_data_type = "String"
    mutable             = true
    required            = true
    string_attribute_constraints {
      min_length = 1
      max_length = 2048
    }
  }

  schema {
    name                = "name"
    attribute_data_type = "String"
    mutable             = true
    required            = true
    string_attribute_constraints {
      min_length = 1
      max_length = 2048
    }
  }

  schema {
    name                = "nickname"
    attribute_data_type = "String"
    mutable             = true
    required            = true
    string_attribute_constraints {
      min_length = 1
      max_length = 2048
    }
  }

  email_configuration {
    email_sending_account = "COGNITO_DEFAULT"
  }

  auto_verified_attributes = ["email"]

  alias_attributes = var.required_attributes


  admin_create_user_config {
    allow_admin_create_user_only = var.allow_admin_create_user_only

    invite_message_template {
      email_subject = var.invite_email.subject
      email_message = var.invite_email.message
      sms_message   = var.invite_email.message
    }
  }

  verification_message_template {
    default_email_option  = var.default_email_option
    email_subject         = var.email_messages.subject.email_subject
    email_message         = var.email_messages.message.email_message
    email_subject_by_link = var.email_messages.subject.email_subject_by_link
    email_message_by_link = var.email_messages.message.email_message_by_link
    sms_message           = var.email_messages.message.sms_message
  }

  sms_configuration {
    external_id    = "bb7434dd-3b23-4fba-a46c-c88e65a1057d"
    sns_caller_arn = var.cognito_pool_role_arn
  }
}

resource "aws_cognito_user_pool_domain" "main" {
  domain       = "${var.project}-${var.owner}"
  user_pool_id = aws_cognito_user_pool.pool_user.id
}


resource "null_resource" "verifying_attribute_changes" {
  triggers = {
    always_run = "${timestamp()}"
  }
  provisioner "local-exec" {
    command = "aws cognito-idp update-user-pool --user-pool-id ${aws_cognito_user_pool.pool_user.id} --user-attribute-update-settings AttributesRequireVerificationBeforeUpdate=email --auto-verified-attributes=email"
    when    = create
  }
}

################################################################################
#! User
################################################################################

resource "aws_cognito_user" "darede_adm" {
  user_pool_id = aws_cognito_user_pool.pool_user.id
  username     = var.users.darede.nickname

  attributes = {
    cnpj           = var.users.darede.cnpj
    nomeCliente    = var.users.darede.nomeCliente
    permissao      = aws_cognito_user_group.administrator.name
    email          = var.users.darede.email
    email_verified = true
    name           = var.users.darede.name
    nickname       = var.users.darede.nickname
  }
}

resource "aws_cognito_user_group" "administrator" {
  user_pool_id = aws_cognito_user_pool.pool_user.id
  name         = "${var.users.darede.cnpj}_Administrator"
  description  = var.cognito_group_description
}

resource "aws_cognito_user_in_group" "adm_in_adm_group" {
  user_pool_id = aws_cognito_user_pool.pool_user.id
  group_name   = aws_cognito_user_group.administrator.name
  username     = aws_cognito_user.darede_adm.username
}

################################################################################
#! Clients
################################################################################

resource "aws_cognito_user_pool_client" "client" {
  name = "${var.global_model}-${var.owner}-${var.project}"

  user_pool_id                         = var.cognito_user_pool_id
  explicit_auth_flows                  = var.client_authflow
  callback_urls                        = ["${var.callback_logout_ulrs[0]}"]
  logout_urls                          = ["${var.callback_logout_ulrs[1]}"]
  allowed_oauth_flows                  = ["code", "implicit"]
  allowed_oauth_scopes                 = var.allowed_oauth_scopes
  supported_identity_providers         = ["COGNITO"]
  allowed_oauth_flows_user_pool_client = true
  prevent_user_existence_errors        = "ENABLED"

  token_validity_units {
    access_token  = "minutes"
    id_token      = "minutes"
    refresh_token = "days"
    // valid values are: seconds | minutes | hours | days
  }
  access_token_validity  = 60
  id_token_validity      = 720
  refresh_token_validity = 30
}

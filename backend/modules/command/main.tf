resource "null_resource" "varivel_ambiente_name" {
  triggers = {
    always_run = "${timestamp()}"
  }
  provisioner "local-exec" {
    command = "chmod +x modules/${var.global_model}/command/scripts/script.sh; ./modules/${var.global_model}/command/scripts/script.sh"
    when    = create
    environment = {
      api_url         = var.api_gateway_endponit
      api_name        = var.api_name
      user_pool_id    = var.app_user_pool_id
      user_client_id  = var.app_user_pool_web_client_id
      cognito_domain  = var.app_cognito_domain
      app_identity_id = var.app_identity_id
      waf_token       = var.waf_token
      state           = var.global_model
    }
  }
}

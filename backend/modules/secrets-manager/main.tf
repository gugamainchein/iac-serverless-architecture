resource "aws_secretsmanager_secret" "secret-firewall" {
  name = "${var.global_stage}-${var.waf_secrets_name}"
}

resource "aws_secretsmanager_secret" "api-user" {
  name = "${var.global_stage}-${var.api_user_secrets_name}"
}

resource "aws_secretsmanager_secret_version" "sversion-firewall" {
  secret_id     = aws_secretsmanager_secret.secret-firewall.id
  secret_string = <<EOF
   {"${var.custom_header_match}": "${var.waf_token}"}
EOF

  depends_on = [
    aws_secretsmanager_secret.secret-firewall
  ]
}

resource "aws_secretsmanager_secret_version" "sversion-api-user" {
  secret_id     = aws_secretsmanager_secret.api-user.id
  secret_string = <<EOF
   {"user": "${var.api_user}","password": "${var.api_user_pass}"}
EOF

  depends_on = [
    aws_secretsmanager_secret.api-user
  ]
}

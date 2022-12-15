output "waf_secrets_arn" {
  value = aws_secretsmanager_secret.secret-firewall.arn
}

output "api_secrets_arn" {
  value = aws_secretsmanager_secret.api-user.arn
}

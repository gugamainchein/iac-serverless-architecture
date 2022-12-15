output "api_name" {
  value = aws_api_gateway_rest_api.api_back_end.name
}

output "api_rest_id" {
  value = aws_api_gateway_rest_api.api_back_end.id
}

output "api_resource_id" {
  value = aws_api_gateway_rest_api.api_back_end.root_resource_id
}

output "api_gateway_arn" {
  value = aws_api_gateway_stage.state_api.arn
}

output "api_gateway_endponit" {
  value = "${aws_api_gateway_deployment.deploy.invoke_url}${aws_api_gateway_stage.state_api.stage_name}"
}


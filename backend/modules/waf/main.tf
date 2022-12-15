locals {
  allowList = aws_wafv2_ip_set.whitelist_cf_ipv4.arn
  whitelist = "${var.global_model}-${var.project}-${var.aws_wafv2_ip_set_name}-api-ipv4"
  prefix    = "${var.global_model}-${var.global_stage}-${var.project}-${var.aws_wafv2_web_acl_name}-${var.global_app_name}"
  metric-role = "metric-${var.global_model}-${var.role_waf}"
  metric-role2 = "metric-${var.global_model}-${var.role2_waf}"
}

resource "aws_wafv2_web_acl" "waf_api_gateway" {
  name        = local.prefix
  description = var.waf_description
  scope       = "REGIONAL"

  default_action {
    block {}
  }

  rule {
    name     = var.role_waf
    priority = 0

    action {
      allow {}
    }

    statement {
      ip_set_reference_statement {
        arn = local.allowList
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = local.metric-role
      sampled_requests_enabled   = true
    }
  }
  rule {
    name     = var.role2_waf
    priority = 1

    action {
      allow {}
    }

    statement {
      byte_match_statement {
        positional_constraint = "EXACTLY"
        search_string         = var.waf_token
        text_transformation {
          priority = 0
          type     = "NONE"
        }
        field_to_match {
          single_header {
            name = var.custom_header_match
          }
        }
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = local.metric-role2
      sampled_requests_enabled   = true
    }
  }

  visibility_config {
    cloudwatch_metrics_enabled = false
    metric_name                = "metric-${local.prefix}"
    sampled_requests_enabled   = false
  }
}

resource "aws_wafv2_ip_set" "whitelist_cf_ipv4" {
  name               = local.whitelist
  scope              = "REGIONAL"
  ip_address_version = "IPV4"
  addresses          = var.ipsAlloweds

  tags = {
    Name = local.whitelist
  }
}

resource "aws_wafv2_web_acl_association" "association_api_gateway" {
  web_acl_arn  = aws_wafv2_web_acl.waf_api_gateway.arn
  resource_arn = var.api_gateway_arn
}



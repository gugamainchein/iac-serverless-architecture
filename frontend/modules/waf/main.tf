locals {
  allowList = aws_wafv2_ip_set.whitelist_cf_ipv4.arn
  whitelist = "${var.project}-${var.aws_wafv2_ip_set_name}-api-ipv4"
  prefix    = "${var.global_stage}-${var.project}-${var.aws_wafv2_web_acl_name}-${var.global_app_name}"
}

resource "aws_wafv2_web_acl" "waf_cf" {
  name        = local.prefix
  description = var.waf_description
  scope       = "CLOUDFRONT"

  default_action {
    block {}
  }

  rule {
    name     = var.role_waf
    priority = 1

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
      metric_name                = "metric-${var.role_waf}"
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
  scope              = "CLOUDFRONT"
  ip_address_version = "IPV4"
  addresses          = var.ipsAlloweds

  tags = {
    Name = local.whitelist
  }
}


resource "aws_cloudfront_distribution" "s3_distribution" {
  web_acl_id = var.waf_arn
  origin {
    domain_name = var.domain_nameS3
    origin_id   = var.domain_nameS3
    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.s3_distribution_access.cloudfront_access_identity_path
    }
  }

  http_version        = "http2and3"
  enabled             = true
  is_ipv6_enabled     = true
  comment             = "${var.global_model}-${var.cf_comment}"
  default_root_object = "index.html"

  default_cache_behavior {
    allowed_methods  = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = var.domain_nameS3

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "redirect-to-https"
    min_ttl                = 0
    default_ttl            = 3100
    max_ttl                = 86400
  }

  custom_error_response {
    error_caching_min_ttl = 10
    error_code            = 404
    response_code         = 200
    response_page_path    = "/"
  }


  restrictions {
    geo_restriction {
      restriction_type = "none"
      locations        = []
    }
  }

  viewer_certificate {
    cloudfront_default_certificate = true
  }

}

resource "aws_cloudfront_origin_access_identity" "s3_distribution_access" {
  comment = var.cf_origin_comment
}

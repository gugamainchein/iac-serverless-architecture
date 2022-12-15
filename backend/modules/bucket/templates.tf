
data "template_file" "policy_bucket_serverless_file" {
  template = file("${path.module}/templates/policy_bucket_serverless.json")
  vars = {
    s3_arn         = "${aws_s3_bucket.serverless_backend_bucket.arn}"
    role_codebuild = "${var.role_codebuild}"
  }
  depends_on = [
    aws_s3_bucket.serverless_backend_bucket
  ]
}

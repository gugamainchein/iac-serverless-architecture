data "template_file" "policy_bucket" {
  template = file("${path.module}/templates/policy_bucket.json")

  vars = {
    cf_origin_arn = "${var.cf_origin_arn}"
    s3_arn = "${aws_s3_bucket.codepipeline-bucket.arn}"
  }

  depends_on = [
    aws_s3_bucket.codepipeline-bucket
  ]
}

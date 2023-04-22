resource "null_resource" "invalidate_cf_cache" {
  provisioner "local-exec" {
    command = "aws cloudfront create-invalidation --distribution-id ${var.cloudfront_id} --paths '/*'"
  }
}

resource "null_resource" "clone_cognito_repo" {
  provisioner "local-exec" {
    command = "rm -rf projects && mkdir projects && cd projects && git clone https://github.com/Sapkotaanish/react-codebuild.git && cd react-codebuild && rm -rf .git && git init && git remote add origin codecommit://${var.profile_aws}@${var.project}-${var.global_app_name} && git checkout -B ${var.global_stage} && git add . && git commit -m 'first commit' && git push origin ${var.global_stage}"
  }
}

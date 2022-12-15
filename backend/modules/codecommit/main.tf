resource "aws_codecommit_repository" "repo-name" {
  repository_name = "${var.project}-${var.global_app_name}"
  description     = var.repository_description
  default_branch  = "master"
}

output "clone_ssh" {
  value = aws_codecommit_repository.repo-name.clone_url_ssh
}

output "repo_name" {
  value = aws_codecommit_repository.repo-name.repository_name
}

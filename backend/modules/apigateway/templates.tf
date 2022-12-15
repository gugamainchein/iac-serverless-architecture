data "template_file" "empty_template_file" {
  template = file("${path.module}/templates/empty.json")
}

data "template_file" "error_template_file" {
  template = file("${path.module}/templates/error.json")
}

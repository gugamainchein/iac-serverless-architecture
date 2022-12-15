data "template_file" "dynamodb_trainning_iten" {
  template = file("${path.module}/templates/dynamodb_trainning_iten.json")
}

data "template_file" "dynamodb_permissions_iten" {
  template = file("${path.module}/templates/dynamodb_permissions_iten.json")
}

data "template_file" "dynamodb_permissions_iten_darede" {
  template = file("${path.module}/templates/dynamodb_permissions_darede.json")
  vars = {
    cnpj      = var.users.darede.cnpj
    time      = formatdate("EEEE, DD-MMM-YY hh:mm:ss ZZZ", "2018-01-02T23:12:01Z")
    goup_name = var.group_name
  }
}

data "template_file" "dynamodb_documents_iten" {
  template = file("${path.module}/templates/dynamodb_documents_iten.json")
}

data "template_file" "dynamodb_audit_iten" {
  template = file("${path.module}/templates/dynamodb_audit_iten.json")
}

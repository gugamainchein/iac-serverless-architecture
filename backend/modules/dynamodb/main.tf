#  prod hml
resource "aws_dynamodb_table" "dynamodb_trainning_table" {
  name         = local.trainning_table
  billing_mode = var.trainning_table.billing_mode
  hash_key     = var.trainning_table.hash_key

  attribute {
    name = var.trainning_table.hash_key
    type = "S"
  }
}

resource "aws_dynamodb_table_item" "dynamodb_trainning_item" {
  table_name = aws_dynamodb_table.dynamodb_trainning_table.name
  hash_key   = aws_dynamodb_table.dynamodb_trainning_table.hash_key

  item = data.template_file.dynamodb_trainning_iten.rendered
}

resource "aws_dynamodb_table" "dynamodb_permissions_table" {
  name         = local.permissions_table
  billing_mode = var.permissions_table.billing_mode
  hash_key     = var.permissions_table.hash_key

  attribute {
    name = var.permissions_table.hash_key
    type = "S"
  }
}

resource "aws_dynamodb_table_item" "dynamodb_permissions_item_base" {
  table_name = aws_dynamodb_table.dynamodb_permissions_table.name
  hash_key   = aws_dynamodb_table.dynamodb_permissions_table.hash_key

  item = data.template_file.dynamodb_permissions_iten.rendered
}

resource "aws_dynamodb_table_item" "dynamodb_permissions_item_darede" {
  table_name = aws_dynamodb_table.dynamodb_permissions_table.name
  hash_key   = aws_dynamodb_table.dynamodb_permissions_table.hash_key

  item = data.template_file.dynamodb_permissions_iten_darede.rendered
}

resource "aws_dynamodb_table" "dynamodb_documents_table" {
  name         = local.documents_table
  billing_mode = var.documents_table.billing_mode
  hash_key     = var.documents_table.hash_key

  attribute {
    name = var.documents_table.hash_key
    type = "S"
  }
}

resource "aws_dynamodb_table_item" "dynamodb_documents_item" {
  table_name = aws_dynamodb_table.dynamodb_documents_table.name
  hash_key   = aws_dynamodb_table.dynamodb_documents_table.hash_key

  item = data.template_file.dynamodb_documents_iten.rendered
}

resource "aws_dynamodb_table" "dynamodb_cosutumers_table" {
  name         = local.cosutumers_table
  billing_mode = var.cosutumers_table.billing_mode
  hash_key     = var.cosutumers_table.hash_key

  attribute {
    name = var.cosutumers_table.hash_key
    type = "S"
  }
}

resource "aws_dynamodb_table" "dynamodb_audit_table" {
  name         = local.audit_table
  billing_mode = var.audit_table.billing_mode
  hash_key     = var.audit_table.hash_key

  attribute {
    name = var.audit_table.hash_key
    type = "S"
  }
}

resource "aws_dynamodb_table_item" "dynamodb_audit_item" {
  table_name = aws_dynamodb_table.dynamodb_audit_table.name
  hash_key   = aws_dynamodb_table.dynamodb_audit_table.hash_key

  item = data.template_file.dynamodb_audit_iten.rendered
}

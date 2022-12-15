locals {
  trainning_table   = "${var.global_model}-${var.global_stage}-${var.trainning_table.table_name}"
  permissions_table = "${var.global_model}-${var.global_stage}-${var.permissions_table.table_name}"
  documents_table   = "${var.global_model}-${var.global_stage}-${var.documents_table.table_name}"
  cosutumers_table  = "${var.global_model}-${var.global_stage}-${var.cosutumers_table.table_name}"
  audit_table       = "${var.global_model}-${var.global_stage}-${var.audit_table.table_name}"
}

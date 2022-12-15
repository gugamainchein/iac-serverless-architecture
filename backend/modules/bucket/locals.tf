locals {
  pipeline    = "${var.global_model}-${var.global_stage}-${var.project}-${var.codepipeline_bucket_name}-${var.global_app_name}"
  serverless  = "${var.global_model}-${var.project}-${var.global_stage}-serverless-${var.global_app_name}"
  costumers   = "${var.global_model}-${var.project}-${var.global_stage}-${var.customers_name}"
  documents   = "${var.global_model}-${var.project}-${var.global_stage}-brute-${var.ml_documents_name}"
}

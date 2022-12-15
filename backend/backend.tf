# terraform {
#   backend "s3" {
#     bucket         = "BUCKET_NAME"
#     key            = "PATH"
#     region         = "REGION"
#     encrypt        = "true"
#     dynamodb_table = "BACKEND_TFSTATE_DYNAMO"
#   }
# }

# # Obs:É interessante o bucket estar com versionmaneto habilitado.

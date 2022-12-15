terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.44"
    }
  }
  required_version = ">= 0.14.9"
}

provider "aws" {
  region  = var.region_aws
  profile = var.profile_aws

  default_tags {
    tags = {
      OWNER   = var.owner
      STAGE   = var.stage
      MANAGED = "terraform"
    }
  }
}

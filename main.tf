terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~>4.0"
    }
  }

  backend "s3" {
    region = var.region
    encrypt = var.encrypt
    bucket = var.bucket
    key = var.key
    dynamodb_table = var.dynamodb_table
  }
}

provider "aws" {
  region = var.aws_region
}

module "terraform_s3_dynamodb_state_locking" {
  source = "./modules/s3-dynamodb-state-locking"

  resource_owner                            = var.resource_owner
  terraform_state_bucket_name               = "tfstate-s3-bucket-${var.aws_region}"
  terraform_state_bucket_description        = "s3 bucket for terraform state management"
  terrafrom_state_locking_table_name        = "tfstate-locking-table-${var.aws_region}"
  terrafrom_state_locking_table_description = "dynamodb table for terraform state locking"
}
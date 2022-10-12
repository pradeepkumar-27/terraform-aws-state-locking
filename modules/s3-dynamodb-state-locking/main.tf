resource "aws_s3_bucket" "terrafrom_state_bucket" {
  bucket = var.terraform_state_bucket_name

  force_destroy = true

  tags = {
    "name"           = var.terraform_state_bucket_name
    "resource-owner" = var.resource_owner
    "description"    = var.terraform_state_bucket_description
  }

  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_s3_bucket_acl" "terrafrom_state_bucket_acl" {
  bucket = aws_s3_bucket.terrafrom_state_bucket.id
  acl    = "private"
}

resource "aws_s3_bucket_versioning" "terrafrom_state_bucket_versioning" {
  bucket = aws_s3_bucket.terrafrom_state_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_public_access_block" "terrafrom_state_bucket_public_access" {
  bucket                  = aws_s3_bucket.terrafrom_state_bucket.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_server_side_encryption_configuration" "terraform_state_bucket_sse" {
  bucket = aws_s3_bucket.terrafrom_state_bucket.id
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_dynamodb_table" "terrafrom_state_locking_table" {
  name         = var.terrafrom_state_locking_table_name
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    "name"           = var.terrafrom_state_locking_table_name
    "resource-owner" = var.resource_owner
    "description"    = var.terrafrom_state_locking_table_description
  }

  lifecycle {
    prevent_destroy = true
  }
}
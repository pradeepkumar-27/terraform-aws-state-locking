variable "terraform_state_bucket_name" {
  description = "terraform state bucket name"
  type        = string
}

variable "terraform_state_bucket_description" {
  description = "terrafrom state bucket description"
  type        = string
}

variable "terrafrom_state_locking_table_name" {
  description = "terraform state locking table name"
  type        = string
}

variable "terrafrom_state_locking_table_description" {
  description = "terrraform state locking table descryption"
  type        = string
}

variable "resource_owner" {
  description = "resource owner"
  type        = string
}
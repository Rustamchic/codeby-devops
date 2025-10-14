variable "region" {
  type    = string
  default = "eu-central-1"
}

variable "bucket_name" {
  type    = string
  default = "rustic-tfstate"
}

variable "lock_table" {
  type    = string
  default = "rustic-terraform-locks"
}

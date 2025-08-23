variable "aws_region" {
  type    = string
  default = "eu-central-1"
}

variable "public_key_path" {
  type    = string
  default = "~/.ssh/tf-lesson14.pub"
}

variable "private_key_path" {
  type    = string
  default = "~/.ssh/tf-lesson14"
}

variable "ssh_user" {
  type    = string
  default = "ubuntu"
}

variable "enable_nat_gateway" {
  type    = bool
  default = true
}

variable "public_subnet_cidr" {
  type    = string
  default = "172.31.100.0/24"
}

variable "private_subnet_cidr" {
  type    = string
  default = "172.31.101.0/24"
}

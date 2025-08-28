variable "aws_region" { type = string, default = "eu-central-1" }
variable "vpc_id"     { type = string }
variable "az"         { type = string }

variable "ami"             { type = string, default = "ami-08c40ec9ead489470" }
variable "instance_type"   { type = string, default = "t3.micro" }
variable "key_name"        { type = string }
variable "security_groups" { type = list(string), default = [] }
variable "associate_public_ip" { type = bool, default = true }

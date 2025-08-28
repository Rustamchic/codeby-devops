variable "vpc_id"             { type = string }
variable "az"                 { type = string }
variable "ami"                { type = string }
variable "instance_type"      { type = string }
variable "key_name"           { type = string }
variable "security_group_ids" { type = list(string), default = [] }
variable "associate_public_ip" { type = bool, default = true }

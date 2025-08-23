data "aws_subnets" "match" {
  filter { name = "vpc-id"            values = [var.vpc_id] }
  filter { name = "availability-zone" values = [var.az] }
}

locals {
  chosen_subnet_id = element(data.aws_subnets.match.ids, 0)
}

resource "aws_security_group" "default" {
  name   = "lesson15-ec2-sg"
  vpc_id = var.vpc_id

  ingress { from_port = 22 to_port = 22 protocol = "tcp" cidr_blocks = ["0.0.0.0/0"] }
  egress  { from_port = 0  to_port = 0  protocol = "-1"   cidr_blocks = ["0.0.0.0/0"] }
}

locals {
  sg_effective = length(var.security_group_ids) > 0 ? var.security_group_ids : [aws_security_group.default.id]
}

resource "aws_instance" "this" {
  ami                         = var.ami
  instance_type               = var.instance_type
  subnet_id                   = local.chosen_subnet_id
  vpc_security_group_ids      = local.sg_effective
  key_name                    = var.key_name
  associate_public_ip_address = var.associate_public_ip

  tags = { Name = "lesson15-ec2" }
}

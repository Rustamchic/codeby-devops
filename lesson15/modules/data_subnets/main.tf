data "aws_subnets" "all" {
  filter {
    name   = "vpc-id"
    values = [var.vpc_id]
  }
}

data "aws_subnet" "by_id" {
  for_each = toset(data.aws_subnets.all.ids)
  id       = each.value
}

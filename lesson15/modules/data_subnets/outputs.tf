output "subnets" {
  value = [
    for s in data.aws_subnet.by_id :
    {
      id         = s.id
      az         = s.availability_zone
      cidr_block = s.cidr_block
      tags       = s.tags
    }
  ]
}

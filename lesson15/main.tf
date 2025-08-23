module "data_subnets" {
  source = "./modules/data_subnets"
  vpc_id = var.vpc_id
}

module "ec2_instance" {
  source               = "./modules/ec2_instance"
  vpc_id               = var.vpc_id
  az                   = var.az
  ami                  = var.ami
  instance_type        = var.instance_type
  key_name             = var.key_name
  security_group_ids   = var.security_groups
  associate_public_ip  = var.associate_public_ip
}

output "all_subnets" {
  value = module.data_subnets.subnets
}

output "instance_id" {
  value = module.ec2_instance.instance_id
}

output "instance_subnet_id" {
  value = module.ec2_instance.subnet_id
}

output "instance_public_ip" {
  value = module.ec2_instance.public_ip
}

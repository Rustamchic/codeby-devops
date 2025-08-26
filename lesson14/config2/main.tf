resource "aws_instance" "imported" {
  ami                         = "ami-08c40ec9ead489470"   # Ubuntu 22.04 LTS (eu-central-1)
  instance_type               = "t3.micro"
  subnet_id                   = "subnet-0abc1234def567890"   # ID public subnet
  vpc_security_group_ids      = ["sg-0abc1234def567890"]     # SG с доступом по SSH/HTTP
  key_name                    = "lesson14-key"
  associate_public_ip_address = true

  tags = {
    Name = "lesson14-imported"
  }
}

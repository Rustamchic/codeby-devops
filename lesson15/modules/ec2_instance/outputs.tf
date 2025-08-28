output "instance_id" { value = aws_instance.this.id }
output "subnet_id"    { value = aws_instance.this.subnet_id }
output "public_ip"    { value = aws_instance.this.public_ip }

output "instance_ip_addr_public" {
  value = aws_eip.terraform_ip.public_ip
}

output "instance_ip_addr_private" {
  value = aws_eip.terraform_ip.private_ip
}
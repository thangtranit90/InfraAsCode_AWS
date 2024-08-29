output "public_security_group_id" {
    value = aws_security_group.EC2_public_security_group.id
}

output "private_security_group_id" {
    value = aws_security_group.EC2_private_security_group.id
}
output "vpc_id" {
  value = aws_vpc.thang-terraform.id
  
}
output "public_subnet_ids" {
    value = [
        aws_subnet.public_subnet_1.id,
        aws_subnet.public_subnet_2.id
    ]
}

  
output "private_subnet_ids" {
    value = [
        aws_subnet.private_subnet_1.id,
        aws_subnet.private_subnet_2.id
    ]
}
output "internet_gateway_id" {
  value = aws_internet_gateway.igw.id
}

output "private_route_table_id" {
  value = aws_route_table.Private_Route_Table.id
  
}


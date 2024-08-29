output "instance_ip_addr_public" {
  value = module.EC2_Public.instance_ip_addr_public
}



output "instance_type" {
  value = var.instance_type
}

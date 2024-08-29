variable "region" {
  type = string
  default = "ap-southeast-1"
}
#parameters for networking module
variable "availability_zone_1" {
  type = string
  nullable = false
}
variable "availability_zone_2" {
  type = string
  nullable = false
}
variable "cidr_block" {
  type = string
  nullable = false
}
variable "public_subnet_ips" {
  type = list(string)
  nullable = false
  
}
variable "private_subnet_ips" {
  type = list(string)
  nullable = false
}

variable "instance_type" {
  type        = string
  description = "The id of the machine image (AMI) to use for the server."
  default = "t3.micro"
}

variable "amis" {
  type        = map(any)
  default = {
    ap-southeast-1 = "ami-0adcfe5c27f7c9acf"
    ap-northeast-1 = "ami-0bdd30a3e20da30a1"
    }
}
#variable "keypair_path" {
#  type        = string
#  default = "../keypair/amazonstudy2.pub"
#}

variable "role_name" {
  description = "The name of the IAM role"
  type        = string
  nullable = false
}
#variable "iam_instance_profile_name" {
#  type = string
#  nullable = false
#}
#
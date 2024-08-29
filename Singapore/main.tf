terraform {
  required_version = ">= 1.5.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0.0"
    }
  }
#  backend "s3" {
#    bucket = "terraform-state-thang"
#   key    = "state/terraform.tfstate"
#   region = "ap-southeast-1"
#   dynamodb_table = "terraform-state"
# }
}
provider "aws" {
  region = var.region
}


#Create a complete VPC using module networking
module "networking" {
  source = "../modules/networking"
  region = var.region
  availability_zone_1 = var.availability_zone_1
  availability_zone_2 = var.availability_zone_2
  cidr_block = var.cidr_block
  public_subnet_ips = var.public_subnet_ips
  private_subnet_ips = var.private_subnet_ips
  tags = {
    Name = "ASG"
  }
}
module "security" {
  source = "../modules/security"
  region = var.region
  vpc_id = module.networking.vpc_id
}

#resource "aws_key_pair" "amazonstudy2" {
#  key_name   = "amazonstudy2"
#  public_key = file(var.keypair_path)
#}
module "EC2_Public" {
  source = "../modules/compute"
  region = var.region
  instance_type = var.instance_type
  image_id = var.amis[var.region]
  #key_name = aws_key_pair.amazonstudy2.key_name
  ec2_security_group_ids = [module.security.public_security_group_id]
  subnet_id = module.networking.public_subnet_ids[0]
  tags = {
    Name = "EC2_Public"
  }
  iam_instance_profile_name = module.ssm-role-2.iam_instance_profile_name
}


module "EC2_Private" {
  source = "../modules/compute"
  tags = {
    Name = "EC2_Private"
  }
  region = var.region
  instance_type = var.instance_type
  image_id = var.amis[var.region]
  #key_name = aws_key_pair.amazonstudy2.key_name
  ec2_security_group_ids = [module.security.private_security_group_id]
  subnet_id = module.networking.private_subnet_ids[1]
  iam_instance_profile_name = module.ssm-role-2.iam_instance_profile_name
}
module "ssm-role-2" {
  source = "../modules/iam-roles"
  role_name = var.role_name
}
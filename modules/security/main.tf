# Hướng dẫn tạo EC2 trên VPC chỉ định bằng ID, không cần khai báo vpc_id, có subnet_id, security_group_id, key_pair_id,public_ip_address

provider "aws" {
    region = var.region
}

resource "aws_security_group" "EC2_public_security_group" {
    name        = "public_security_group"
    description = "SG Public for EC2 Public"
    vpc_id = var.vpc_id
    ingress {
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        from_port   = -1
        to_port     = -1
        protocol    = "icmp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "EC2_private_security_group" {
    name        = "private_security_group"
    description = "SG for EC2 Private"
    vpc_id = var.vpc_id
    ingress {
        from_port   = -1
        to_port     = -1
        protocol    = "icmp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    }
  
}



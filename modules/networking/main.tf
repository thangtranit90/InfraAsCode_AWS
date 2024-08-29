# this file create : funtion
# - create vpc
# - create internet gateway
# - create Public subnet 1
# - create Public subnet 2
# - create private subnet 1
# - create private subnet 2
# - create elastic ip for nat gateway
# - create nat gateway- gán elastic ip cho nat gateway
# - create Public route table
# - create route trong Public route table
# - create private route table
# - gán nat gateway cho route table
# - associate route table với private subnet và Public subnet tương ứng

provider "aws" {
  region = var.region
  }

# Create VPC 
resource "aws_vpc" "thang-terraform" {
  cidr_block = var.cidr_block
  enable_dns_hostnames = true
  tags = var.tags
}

# Create Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.thang-terraform.id
  tags = {
    Name = "Lab IGW"
  }
}

# Create Public Subnet 

resource "aws_subnet" "public_subnet_1" {
    vpc_id = aws_vpc.thang-terraform.id
    cidr_block = var.public_subnet_ips[0]
    availability_zone = var.availability_zone_1
    tags = {
        Name = "Public Subnet 1"
    }
}
resource "aws_subnet" "public_subnet_2" {
    vpc_id = aws_vpc.thang-terraform.id
    cidr_block = var.public_subnet_ips[1]
    availability_zone = var.availability_zone_2
    tags = {
        Name = "Public Subnet 2"
    }
}
# Create Private Subnet
resource "aws_subnet" "private_subnet_1" {
    vpc_id = aws_vpc.thang-terraform.id
    cidr_block = var.private_subnet_ips[0]
    availability_zone = var.availability_zone_1
    tags = {
        Name = "Private Subnet 1"
    }
  
}
resource "aws_subnet" "private_subnet_2" {
    vpc_id = aws_vpc.thang-terraform.id
    cidr_block = var.private_subnet_ips[1]
    availability_zone = var.availability_zone_2
    tags = {
        Name = "Private Subnet 1"
    }
  
}
# create elastic ip for nat gateway
resource "aws_eip" "nat_eip" {
}
# create nat gateway- gán elastic ip cho nat gateway
resource "aws_nat_gateway" "nat_gw" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.public_subnet_1.id
  tags = {
    Name = "gw NAT"
  }
}
# create Public route table
resource "aws_route_table" "Public_Route_Table" {
  vpc_id = aws_vpc.thang-terraform.id
  tags = {
    Name = "Route Table Public"
  }
}
resource "aws_route" "Public_Route" {
  route_table_id = aws_route_table.Public_Route_Table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.igw.id  
}
# create Private route table
resource"aws_route_table" "Private_Route_Table" {
  vpc_id = aws_vpc.thang-terraform.id
  tags = {
    Name = "Route Table Private"
  }
}
resource "aws_route" "Private_route" {
  route_table_id = aws_route_table.Private_Route_Table.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id = aws_nat_gateway.nat_gw.id
  
}
# associate route table với Private subnet và Public subnet tương ứng
resource "aws_route_table_association" "private_subnet_association_1" {
  subnet_id      = aws_subnet.private_subnet_1.id
  route_table_id = aws_route_table.Private_Route_Table.id
}
resource "aws_route_table_association" "private_subnet_association_2" {
  subnet_id      = aws_subnet.private_subnet_2.id
  route_table_id = aws_route_table.Private_Route_Table.id
}
resource "aws_route_table_association" "public_subnet_association_1" {
  subnet_id = aws_subnet.public_subnet_1.id
  route_table_id = aws_route_table.Public_Route_Table.id
}

resource "aws_route_table_association" "public_subnet_association_2" {
  subnet_id = aws_subnet.public_subnet_2.id
  route_table_id = aws_route_table.Public_Route_Table.id
}
#
resource "aws_eip" "terraform_ip" {
    instance = aws_instance.EC2_terraform.id
  
}

resource "aws_instance" "EC2_terraform" {
    instance_type = var.instance_type
    ami = var.image_id
    subnet_id = var.subnet_id
    #key_name = var.key_name
    vpc_security_group_ids = var.ec2_security_group_ids
    tags = var.tags
    iam_instance_profile = var.iam_instance_profile_name
}


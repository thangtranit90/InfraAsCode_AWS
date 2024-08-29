variable "instance_type" {
  type = string
  default = "t2.micro"
}

variable "image_id" {
  type = string
  
}

#variable "key_name" {
#    type = string
#    nullable = false
#}

variable "ec2_security_group_ids" {
  type = list(string)
  nullable = false
}
variable "region" {
  type = string
  default = "ap-southeast-1"
  
}

variable "subnet_id" {
    type = string
    nullable = false
}
variable "tags" {
  description = "Tags to apply to the instance"
  type        = map(string)
  default     = {}
}
variable "iam_instance_profile_name" {
  type = string
  nullable = true
}

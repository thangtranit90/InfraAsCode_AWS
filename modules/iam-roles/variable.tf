variable "tags" {
  description = "Tags to apply to IAM roles"
  type        = map(string)
  default     = {}
}
variable "role_name" {
  description = "The name of the IAM role"
  type        = string
}
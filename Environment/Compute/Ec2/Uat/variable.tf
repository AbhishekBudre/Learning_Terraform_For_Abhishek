variable "instance_ami_id" {
  type = string
}
variable "instance_type" {
  type = string
}
# variable "subnet_id" {
#   type = string
# }
variable "associate_public_ip_address" {
  type = bool
}
variable "environment" {
  type = string
}
variable "aws_region" {
  type = string
}
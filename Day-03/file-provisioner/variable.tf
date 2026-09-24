variable "instance_ami_id" {
type = string
default = "ami-01a00762f46d584a1"
}
variable "instance_type" {
    type = string
    default = "t3.micro"
}
variable "subnet_id" {
  type = string
  default = "subnet-084380fc740c00288"
}
variable "environment" {
  type = string
  default = "dev"
}

variable "sg_name" {
  type = string
  default = "abhishek_sg.tf"
}
variable "vpc_id" {
  type = string
  description = "This is the vpc id for the security group"
  default = "vpc-09f156d079a68f8bf"
}
variable "key_name" {
  type = string
  default = "abhishek-key-pair"
}
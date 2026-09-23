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
  default = "subnet-0c720d9563977ae68"
}
variable "environment" {
  type = string
  default = "dev"
}
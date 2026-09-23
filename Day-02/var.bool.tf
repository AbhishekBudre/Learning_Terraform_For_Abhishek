variable "subnet_id" {
  type = string
  default = "subnet-060cd23a092cf1719"
}

variable "associate_public_ip" {
    description = "Whether to associate a public IP address with the instance"
    type = bool
    default = true
}

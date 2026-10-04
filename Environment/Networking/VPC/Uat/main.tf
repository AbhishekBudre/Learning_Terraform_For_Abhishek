module "vpc_module" {
  source = "../../../../modules/Networking/VPC"
  
aws_vpc_cidr = var.aws_vpc_cidr
enable_dns_hostnames = var.enable_dns_hostnames
enable_dns_support = var.enable_dns_support
environment = var.environment
public_subnet_01_cidr = var.public_subnet_01_cidr
public_subnet_01_availability_zone_1a = var.public_subnet_01_availability_zone_1a
map_public_ip_on_launch = var.map_public_ip_on_launch

public_subnet_02_cidr = var.public_subnet_02_cidr
public_subnet_02_availability_zone_1b = var.public_subnet_02_availability_zone_1b
public_subnet_03_cidr = var.public_subnet_03_cidr

public_subnet_03_availability_zone_1c = var.public_subnet_03_availability_zone_1c
private_subnet_01_cidr = var.private_subnet_01_cidr
private_subnet_01_availability_zone_1a = var.private_subnet_01_availability_zone_1a

private_subnet_02_cidr = var.private_subnet_02_cidr
private_subnet_02_availability_zone_1b = var.private_subnet_02_availability_zone_1b 
private_subnet_03_cidr = var.private_subnet_03_cidr
private_subnet_03_availability_zone_1c = var.private_subnet_03_availability_zone_1c

eip_name_01 = var.eip_name_01
eip_name_02 = var.eip_name_02
eip_name_03 = var.eip_name_03

aws_region = var.aws_region
}
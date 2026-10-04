
aws_vpc_cidr = "10.0.0.0/16"
enable_dns_hostnames = true
enable_dns_support = true
environment = "Dev"
public_subnet_01_cidr = "10.0.1.0/24"
public_subnet_01_availability_zone_1a = "ap-south-1a"
map_public_ip_on_launch = true

public_subnet_02_cidr = "10.0.8.0/24"
public_subnet_02_availability_zone_1b = "ap-south-1b"
public_subnet_03_cidr = "10.0.16.0/24"

public_subnet_03_availability_zone_1c = "ap-south-1c"
private_subnet_01_cidr = "10.0.32.0/24"
private_subnet_01_availability_zone_1a = "ap-south-1a"

private_subnet_02_cidr = "10.0.48.0/24"
private_subnet_02_availability_zone_1b = "ap-south-1b"
private_subnet_03_cidr = "10.0.56.0/24"
private_subnet_03_availability_zone_1c = "ap-south-1c"

eip_name_01 = "abhi-eip-01"
eip_name_02 = "abhi-eip-02"
eip_name_03 = "abhi-eip-03"

aws_region = "ap-south-1"
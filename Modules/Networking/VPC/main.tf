##################This is the Vpc Block########################

resource "aws_vpc" "abhishek" {
  cidr_block       = var.aws_vpc_cidr
  enable_dns_hostnames = var.enable_dns_hostnames
  enable_dns_support = var.enable_dns_support

  tags = {
    Name = "${var.environment}-Abhishek-vpc"
  }
}

################### This is the all public subnet blocks frome line 15 to 46 ################

resource "aws_subnet" "public_subnet_01" {
  vpc_id     = aws_vpc.abhishek.id
  cidr_block = var.public_subnet_01_cidr
  availability_zone = var.public_subnet_01_availability_zone_1a
  map_public_ip_on_launch = var.map_public_ip_on_launch

  tags = {
    Name = "${var.public_subnet_01_availability_zone_1a}-public_subnet_01"
  }
}

resource "aws_subnet" "public_subnet_02" {
  vpc_id     = aws_vpc.abhishek.id
  cidr_block = var.public_subnet_02_cidr
  availability_zone = var.public_subnet_02_availability_zone_1b
  map_public_ip_on_launch = var.map_public_ip_on_launch

  tags = {
    Name = "${var.public_subnet_02_availability_zone_1b}-public_subnet_02"
  }
}

resource "aws_subnet" "public_subnet_03" {
  vpc_id     = aws_vpc.abhishek.id
  cidr_block = var.public_subnet_03_cidr
  availability_zone = var.public_subnet_03_availability_zone_1c
  map_public_ip_on_launch = var.map_public_ip_on_launch

  tags = {
    Name = "${var.public_subnet_03_availability_zone_1c}-public_subnet_03"
  }
}
################# This is the all private subnet blocks frome line 49 to 80 ################

resource "aws_subnet" "private_subnet_01" {
  vpc_id     = aws_vpc.abhishek.id
  cidr_block = var.private_subnet_01_cidr
  availability_zone = var.private_subnet_01_availability_zone_1a


  tags = {
    Name = "${var.private_subnet_01_availability_zone_1a}-private_subnet_01"
  }
}

resource "aws_subnet" "private_subnet_02" {
  vpc_id     = aws_vpc.abhishek.id
  cidr_block = var.private_subnet_02_cidr
  availability_zone = var.private_subnet_02_availability_zone_1b


  tags = {
    Name = "${var.private_subnet_02_availability_zone_1b}-private_subnet_02"
  }
}

resource "aws_subnet" "private_subnet_03" {
  vpc_id     = aws_vpc.abhishek.id
  cidr_block = var.private_subnet_03_cidr
  availability_zone = var.private_subnet_03_availability_zone_1c


  tags = {
    Name = "${var.private_subnet_03_availability_zone_1c}-private_subnet_03"
  }
}
####### This is the internet gateway block #########
resource "aws_internet_gateway" "abhi_igw" {
  vpc_id = aws_vpc.abhishek.id

  tags = {
    Name = "${var.environment}-abhi_public_igw"
  }
}


resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.abhishek.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.abhi_igw.id
  }

  tags = {
    Name = "${var.environment}-abhi_public_rt"
  }
}


resource "aws_route_table_association" "public_subnet_assocation_01" {
  subnet_id      = aws_subnet.public_subnet_01.id
  route_table_id = aws_route_table.public_rt.id
}
resource "aws_route_table_association" "public_subnet_assocation_02" {
  subnet_id      = aws_subnet.public_subnet_02.id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_route_table_association" "public_subnet_assocation_03" {
  subnet_id      = aws_subnet.public_subnet_03.id
  route_table_id = aws_route_table.public_rt.id
}

#######This is the elastic ip block ############
resource "aws_eip" "nat_eip_01" {
  domain   = "vpc"
  tags = {
    Name = var.eip_name_01
  }
}

###### This is the Nat gatway block ############

resource "aws_nat_gateway" "private_nat_01" {
  allocation_id = aws_eip.nat_eip_01.id
  subnet_id     = aws_subnet.public_subnet_01.id

  tags = {
    Name = "${var.environment}-abhi_private_nat_gw_01"
  }

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.abhi_igw]
}

resource "aws_route_table" "private_rt_01" {
  vpc_id = aws_vpc.abhishek.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.private_nat_01.id
  }

  tags = {
    Name = "${var.environment}-abhi_private_rt_01"
  }
}

resource "aws_route_table_association" "private_subnet_assocation_01" {
  subnet_id      = aws_subnet.private_subnet_01.id
  route_table_id = aws_route_table.private_rt_01.id
}


resource "aws_eip" "nat_eip_02" {
  domain   = "vpc"
  tags = {
    Name = var.eip_name_02
  }
}
resource "aws_nat_gateway" "private_nat_02" {
  allocation_id = aws_eip.nat_eip_02.id
  subnet_id     = aws_subnet.public_subnet_02.id

  tags = {
    Name = "${var.environment}-abhi_private_nat_gw_02"
  }

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.abhi_igw]
}
resource "aws_route_table" "private_rt_02" {
  vpc_id = aws_vpc.abhishek.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.private_nat_02.id
  }

  tags = {
    Name = "${var.environment}-abhi_private_rt_02"
  }
}
resource "aws_route_table_association" "private_subnet_assocation_02" {
  subnet_id      = aws_subnet.private_subnet_02.id
  route_table_id = aws_route_table.private_rt_02.id
}

resource "aws_eip" "nat_eip_03" {
  domain   = "vpc"
  tags = {
    Name = var.eip_name_03
  }
}
resource "aws_nat_gateway" "private_nat_03" {
  allocation_id = aws_eip.nat_eip_03.id
  subnet_id     = aws_subnet.public_subnet_03.id

  tags = {
    Name = "${var.environment}-abhi_private_nat_gw_03"
  }

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.abhi_igw]
}
resource "aws_route_table" "private_rt_03" {
  vpc_id = aws_vpc.abhishek.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.private_nat_03.id
  }

  tags = {
    Name = "${var.environment}-abhi_private_rt_03"
  }
}
resource "aws_route_table_association" "private_subnet_assocation_03" {
  subnet_id      = aws_subnet.private_subnet_03.id
  route_table_id = aws_route_table.private_rt_03.id
}
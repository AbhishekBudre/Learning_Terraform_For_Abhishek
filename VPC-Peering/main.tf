#########################################
# Production VPC
#########################################

resource "aws_vpc" "production_vpc_1" {
  cidr_block       = var.aws_vpc_1_cidr
  enable_dns_hostnames = true
  enable_dns_support = true

  tags = {
    Name = "${var.vpc_name}_Perring_1"
  }
}
resource "aws_vpc" "production_vpc_2" {
  cidr_block       = var.aws_vpc_2_cidr
  enable_dns_hostnames = true
  enable_dns_support = true

  tags = {
    Name = "${var.vpc_name}_Perring_2"
  }
}
resource "aws_vpc" "production_vpc_3" {
  cidr_block       = var.aws_vpc_3_cidr
  enable_dns_hostnames = true
  enable_dns_support = true

  tags = {
    Name = "${var.vpc_name}_Perring_3"
  }
}

####################################
# Production vpc Subnets
####################################

resource "aws_subnet" "production_vpc_1_subnet" {
  vpc_id                  = aws_vpc.production_vpc_1.id
  cidr_block              = var.production_vpc_1_subnet_cidr
  availability_zone       = var.production_vpc_1_availability_zone
  map_public_ip_on_launch = true

  tags = {
    Name        = "production_vpc_1_subnet-${var.production_vpc_1_availability_zone}"
  }
}
resource "aws_subnet" "production_vpc_2_subnet" {
  vpc_id                  = aws_vpc.production_vpc_2.id
  cidr_block              = var.production_vpc_2_subnet_cidr
  availability_zone       = var.production_vpc_2_availability_zone
  map_public_ip_on_launch = true

  tags = {
    Name        = "vpc_peering_2-Subnet-${var.production_vpc_2_availability_zone}"
  }
}
resource "aws_subnet" "production_vpc_3_subnet" {
  vpc_id                  = aws_vpc.production_vpc_3.id
  cidr_block              =  var.production_vpc_3_subnet_cidr
  availability_zone       = var.production_vpc_3_availability_zone
  map_public_ip_on_launch = true

  tags = {
    Name        = "vpc_peering_2-Subnet-${var.production_vpc_3_availability_zone}"
  }
}

####################################
# Production vpc igw
###################################

resource "aws_internet_gateway" "production_vpc_1_igw" {
  vpc_id   = aws_vpc.production_vpc_1.id

  tags = {
    Name        = "vpc_peering_1-IGW"
  }
}
resource "aws_internet_gateway" "production_vpc_2_igw" {
  vpc_id   = aws_vpc.production_vpc_2.id

  tags = {
    Name        = "vpc_peering_2-IGW"
  }
}
resource "aws_internet_gateway" "production_vpc_3_igw" {
  vpc_id   = aws_vpc.production_vpc_3.id

  tags = {
    Name        = "vpc_peering_3-IGW"
  }
}

#######################################
# Production vpc Route Tables
#######################################

resource "aws_route_table" "production_vpc_1_rt" {
  vpc_id   = aws_vpc.production_vpc_1.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.production_vpc_1_igw.id
  }

  tags = {
    Name        = "vpc_peering_1-Route-Table"
    Environment = "Demo"
  }
}
resource "aws_route_table" "production_vpc_2_rt" {
  vpc_id   = aws_vpc.production_vpc_2.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.production_vpc_2_igw.id
  }

  tags = {
    Name        = "vpc_peering_2-Route-Table"
    Environment = "Demo"
  }
}
resource "aws_route_table" "production_vpc_3_rt" {
  vpc_id   = aws_vpc.production_vpc_3.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.production_vpc_3_igw.id
  }

  tags = {
    Name        = "vpc_peering_3-Route-Table"
    Environment = "Demo"
  }
}

###########################################
# Production vpc RTA Asso
##########################################

resource "aws_route_table_association" "production_vpc_1_rta" {
  subnet_id      = aws_subnet.production_vpc_1_subnet.id
  route_table_id = aws_route_table.production_vpc_1_rt.id
}
resource "aws_route_table_association" "production_vpc_2_rta" {
  subnet_id      = aws_subnet.production_vpc_2_subnet.id
  route_table_id = aws_route_table.production_vpc_2_rt.id
}
resource "aws_route_table_association" "production_vpc_3_rta" {
  subnet_id      = aws_subnet.production_vpc_3_subnet.id
  route_table_id = aws_route_table.production_vpc_3_rt.id
}


############################################
# VPC 1 <-> VPC 2
############################################

# VPC Peering Connection (Requester side - Primary VPC)
resource "aws_vpc_peering_connection" "production_vpc_1_to_production_vpc_2" {
  vpc_id      = aws_vpc.production_vpc_1.id
  peer_vpc_id = aws_vpc.production_vpc_2.id
  peer_region = "ap-south-1"
  auto_accept = false

  tags = {
    Name        = "production_vpc_1_to_production_vpc_2-peering"
    Environment = "Demo"
    Side        = "Requester"
  }
}
resource "aws_vpc_peering_connection_accepter" "production_vpc_2_accepter" {
  vpc_peering_connection_id = aws_vpc_peering_connection.production_vpc_1_to_production_vpc_2.id
  auto_accept               = true

  tags = {
    Name        = "Production_vpc_2-Peering-Accepter"
    Environment = "Demo"
    Side        = "Accepter"
  }
}
# VPC 1 -> VPC 2
resource "aws_route" "production_vpc_1_to_production_vpc_2" {
  route_table_id            = aws_route_table.production_vpc_1_rt.id
  destination_cidr_block    = var.aws_vpc_2_cidr
  vpc_peering_connection_id = aws_vpc_peering_connection.production_vpc_1_to_production_vpc_2.id

  depends_on = [aws_vpc_peering_connection_accepter.production_vpc_2_accepter]
}
# VPC 2 -> VPC 1
resource "aws_route" "vpc_peering_2_to_vpc_peering_1" {
  route_table_id            = aws_route_table.production_vpc_2_rt.id
  destination_cidr_block    = var.aws_vpc_1_cidr
  vpc_peering_connection_id = aws_vpc_peering_connection.production_vpc_1_to_production_vpc_2.id

  depends_on = [aws_vpc_peering_connection_accepter.production_vpc_2_accepter]
  
}

##############################################
# VPC 2 <-> VPC 3
##############################################
resource "aws_vpc_peering_connection" "production_vpc_2_to_production_vpc_3" {
  vpc_id      = aws_vpc.production_vpc_2.id
  peer_vpc_id = aws_vpc.production_vpc_3.id
  peer_region = "ap-south-1"
  auto_accept = false

  tags = {
    Name        = "production_vpc_2_to_production_vpc_3-peering"
    Environment = "Demo"
    Side        = "Requester"
  }
}
resource "aws_vpc_peering_connection_accepter" "production_vpc_3_accepter" {
  vpc_peering_connection_id = aws_vpc_peering_connection.production_vpc_2_to_production_vpc_3.id
  auto_accept               = true

  tags = {
    Name        = "production_vpc_3-Peering-Accepter"
    Environment = "Demo"
    Side        = "Accepter"
  }
}

# VPC 2 -> VPC 3
resource "aws_route" "production_vpc_2_to_production_vpc_3" {
  route_table_id            = aws_route_table.production_vpc_2_rt.id
  destination_cidr_block    = var.aws_vpc_3_cidr
  vpc_peering_connection_id = aws_vpc_peering_connection.production_vpc_2_to_production_vpc_3.id

  depends_on = [aws_vpc_peering_connection_accepter.production_vpc_3_accepter]
  
}

# VPC 3 -> VPC 2
resource "aws_route" "production_vpc_3_to_production_vpc_2" {
  route_table_id            = aws_route_table.production_vpc_3_rt.id
  destination_cidr_block    = var.aws_vpc_2_cidr
  vpc_peering_connection_id = aws_vpc_peering_connection.production_vpc_2_to_production_vpc_3.id

  depends_on = [aws_vpc_peering_connection_accepter.production_vpc_3_accepter]
  
}


#############################################
# VPC 3 <-> VPC 1
#############################################
resource "aws_vpc_peering_connection" "production_vpc_3_to_production_vpc_1" {
  vpc_id      = aws_vpc.production_vpc_3.id
  peer_vpc_id = aws_vpc.production_vpc_1.id
  peer_region = "ap-south-1"
  auto_accept = false

  tags = {
    Name        = "production_vpc_3_to_production_vpc_1-peering"
    Environment = "Demo"
    Side        = "Requester"
  }
}
resource "aws_vpc_peering_connection_accepter" "production_vpc_1_accepter" {
  vpc_peering_connection_id = aws_vpc_peering_connection.production_vpc_3_to_production_vpc_1.id
  auto_accept               = true

  tags = {
    Name        = "production_vpc_1-Accepter"
    Environment = "Demo"
    Side        = "Accepter"
  }
}

# VPC 3 -> VPC 1

resource "aws_route" "production_vpc_3_to_production_vpc_1" {
  route_table_id            = aws_route_table.production_vpc_3_rt.id
  destination_cidr_block    = var.aws_vpc_1_cidr
  vpc_peering_connection_id = aws_vpc_peering_connection.production_vpc_3_to_production_vpc_1.id

  depends_on = [ aws_vpc_peering_connection_accepter.production_vpc_1_accepter
  ]
}

# VPC 1 -> VPC 3

resource "aws_route" "production_vpc_1_to_production_vpc_3" {
  route_table_id            = aws_route_table.production_vpc_1_rt.id
  destination_cidr_block    = var.aws_vpc_3_cidr
  vpc_peering_connection_id = aws_vpc_peering_connection.production_vpc_3_to_production_vpc_1.id

  depends_on = [aws_vpc_peering_connection_accepter.production_vpc_1_accepter
  ]
}

############################################
# Production vpc 1 SG
############################################

resource "aws_security_group" "production_vpc_1_sg" {
  name        = "production_vpc_1_sg"
  description = "Security group for VPC Peering 1 instance"
  vpc_id      = aws_vpc.production_vpc_1.id
}
resource "aws_vpc_security_group_ingress_rule" "allow_ssh_ipv4" {
  security_group_id = aws_security_group.production_vpc_1_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}
resource "aws_vpc_security_group_ingress_rule" "allow_icmp_ipv4" {
  security_group_id = aws_security_group.production_vpc_1_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "icmp"
  from_port         = -1
  to_port           = -1

}
resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.production_vpc_1_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}

############################################
# Production vpc 2 SG
############################################ 

resource "aws_security_group" "production_vpc_2_sg" {
  name        = "production_vpc_2_sg"
  description = "Security group for VPC Peering 2 instance"
  vpc_id      = aws_vpc.production_vpc_2.id

  ingress {
    description = "SSH from anywhere"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "ICMP from Primary VPC"
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = [var.aws_vpc_1_cidr,var.aws_vpc_3_cidr]
  }

  ingress {
    description = "All traffic from Primary VPC"
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "production-VPC-2-SG"
    Environment = "Demo"
  }
}

############################################
# Production vpc 3 SG 
############################################

resource "aws_security_group" "production_vpc_3_sg" {
  name        = "production_vpc_3_sg"
  description = "Security group for VPC Peering 2 instance"
  vpc_id      = aws_vpc.production_vpc_3.id

  ingress {
    description = "SSH from anywhere"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "ICMP from Primary VPC"
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = [var.aws_vpc_1_cidr,var.aws_vpc_2_cidr]
  }

  ingress {
    description = "All traffic from Primary VPC"
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "production-VPC-3-SG"
    Environment = "Demo"
  }
}

#############################################
# Production vpc 1 Instance
#############################################

resource "aws_instance" "production_vpc_1_instance" {
  ami                    = data.aws_ami.production_vpc_1_instance_ami.id
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.production_vpc_1_subnet.id
  vpc_security_group_ids = [aws_security_group.production_vpc_1_sg.id]
  key_name               = var.production_vpc_1_instance_key_name

  user_data = local.production_vpc_1_instance_user_data

  tags = {
    Name        = "production_vpc_1-Instance"
    Environment = "Demo"
    Region      = var.production_vpc_1_region
  }

  depends_on = [aws_vpc_peering_connection_accepter.production_vpc_2_accepter]
}

###########################################################
# Production vpc 2 Instance
###########################################################

resource "aws_instance" "production_vpc_2_instance" {
  ami                    = data.aws_ami.production_vpc_2_instance_ami.id
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.production_vpc_2_subnet.id
  vpc_security_group_ids = [aws_security_group.production_vpc_2_sg.id]
  key_name               = var.production_vpc_2_instance_key_name

  user_data = local.production_vpc_2_instance_user_data

  tags = {
    Name        = "production-VPC-2-Instance"
    Environment = "Demo"
    Region      = var.production_vpc_2_region
  }

  depends_on = [aws_vpc_peering_connection_accepter.production_vpc_3_accepter]
}

#############################################
# Production vpc 3 Instance
#############################################

resource "aws_instance" "production_vpc_3_instance" {
  ami                    = data.aws_ami.production_vpc_3_instance_ami.id
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.production_vpc_3_subnet.id
  vpc_security_group_ids = [aws_security_group.production_vpc_3_sg.id]
  key_name               = var.production_vpc_3_instance_key_name

  user_data = local.production_vpc_3_instance_user_data

  tags = {
    Name        = "production-VPC-3-Instance"
    Environment = "Demo"
    Region      = var.production_vpc_3_region
  }

  depends_on = [aws_vpc_peering_connection_accepter.production_vpc_1_accepter]
}

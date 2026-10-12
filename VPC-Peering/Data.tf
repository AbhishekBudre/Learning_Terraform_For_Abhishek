# Data Sources for VPC Peering Demo

# Data source to get available AZs in Primary region
data "aws_availability_zones" "production_vpc_1" {

  state    = "available"
}

# Data source to get available AZs in Secondary region
data "aws_availability_zones" "production_vpc_2" {

  state    = "available"
}
data "aws_availability_zones" "production_vpc_3" {

  state    = "available"
}

# Data source for Production vpc 1 region AMI (Ubuntu 24.04 LTS)
data "aws_ami" "production_vpc_1_instance_ami" {

  most_recent = true

  #We restricted AMI discovery using official publisher account IDs to ensure trusted image sourcing and avoid accidental deployment of unverified public AMIs.”
  owners      = ["099720109477"] # Canonical (Ubuntu)

#  Common Official Owner IDs
# Ubuntu (Canonical)
# 099720109477
# Amazon Linux
# 137112412989
# Red Hat
# 309956199498

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
}

# Data source for Production vpc 2 region AMI (Ubuntu 24.04 LTS)
data "aws_ami" "production_vpc_2_instance_ami" {

  most_recent = true
  owners      = ["099720109477"] # Canonical (Ubuntu)
  # you can explore more https://documentation.ubuntu.com/aws/aws-how-to/instances/find-ubuntu-images/

  # tou can aslo run this commands aws ec2 describe-images \ --owners 099720109477 \ --region ap-south-1

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
}

data "aws_ami" "production_vpc_3_instance_ami" {

  most_recent = true
  owners      = ["099720109477"] # Canonical (Ubuntu)
  # you can explore more https://documentation.ubuntu.com/aws/aws-how-to/instances/find-ubuntu-images/

  # tou can aslo run this commands aws ec2 describe-images \ --owners 099720109477 \ --region ap-south-1

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
}
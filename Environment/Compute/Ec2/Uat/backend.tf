terraform {
  backend "s3" {
    bucket = "terraform-backend-bucket-1234"
    key    = "Compute/Abhishek/Uat/Ec2/terraform.tfstate"
    region = "ap-south-1"
  }
}

terraform {
  backend "s3" {
    bucket = "terraform-backend-bucket-1234"
    key    = "compute/Abhi/local-provisioner/test/terraform.tfstate"
    region = "ap-south-1"
  }
}

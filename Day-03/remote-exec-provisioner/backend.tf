terraform {
  backend "s3" {
    bucket = "terraform-backend-bucket-1234"
    key    = "compute/Abhi/dev/test/terraform.tfstate"
    region = "ap-south-1"
  }
}

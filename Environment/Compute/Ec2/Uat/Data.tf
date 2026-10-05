data "terraform_remote_state" "vpc_backend" {
 backend = "s3"

  config = {
   bucket = "terraform-backend-bucket-1234"
    key    = "Networking/Abhishek/Uat/Vpc/terraform.tfstate"
    region = "ap-south-1"

}
}
module "instance_module" {
  source = "../../../../Modules/Compute/Ec2"
 instance_ami_id = var.instance_ami_id
  instance_type = var.instance_type
associate_public_ip_address = var.associate_public_ip_address
  environment = var.environment
  aws_region = var.aws_region
  subnet_id = data.terraform_remote_state.vpc_backend.outputs.public_subnet_03_id
}
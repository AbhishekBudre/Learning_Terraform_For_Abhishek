module "security_group_module" {
  source = "../../../../Modules/Security/Security-groups"
  sg_name = var.sg_name
  vpc_id = data.terraform_remote_state.vpc_backend.outputs.vpc_id
  environment = var.environment
  aws_region = var.aws_region
}

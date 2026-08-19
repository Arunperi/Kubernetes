data "terraform_remote_state" "vpc" {
  backend = "s3"

  config = {
    bucket = var.remote_state_bucket
    key    = var.vpc_state_key
    region = var.region
  }
}

module "ec2_security_group" {
  source = "../../../modules/sg"

  name        = var.ec2_sg_name
  vpc_id      = data.terraform_remote_state.vpc.outputs.vpc_id
  ip_protocol = var.ec2_ip_protocol
  from_port   = var.ec2_from_port
  to_port     = var.ec2_to_port
  cidr_ipv4   = var.ec2_cidr_ipv4

  egress_ip_protocol = var.ec2_egress_ip_protocol
  egress_from_port   = var.ec2_egress_from_port
  egress_to_port     = var.ec2_egress_to_port
  egress_cidr_ipv4   = var.ec2_egress_cidr_ipv4
}

module "eks_security_group" {
  source = "../../../modules/sg"

  name                         = var.eks_sg_name
  vpc_id                       = data.terraform_remote_state.vpc.outputs.vpc_id
  ip_protocol                  = var.eks_ip_protocol
  from_port                    = var.eks_from_port
  to_port                      = var.eks_to_port
  referenced_security_group_id = module.ec2_security_group.security_group_id

  egress_ip_protocol = var.eks_egress_ip_protocol
  egress_from_port   = var.eks_egress_from_port
  egress_to_port     = var.eks_egress_to_port
  egress_cidr_ipv4   = var.eks_egress_cidr_ipv4
}
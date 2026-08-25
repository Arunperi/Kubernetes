data "terraform_remote_state" "vpc" {
  backend = "s3"

  config = {
    bucket = var.remote_state_bucket
    key    = var.vpc_state_key
    region = var.region
  }
}

data "terraform_remote_state" "iam" {
  backend = "s3"

  config = {
    bucket = var.remote_state_bucket
    key    = var.iam_state_key
    region = var.region
  }
}

data "terraform_remote_state" "sg" {
  backend = "s3"

  config = {
    bucket = var.remote_state_bucket
    key    = var.sg_state_key
    region = var.region
  }
}

data "terraform_remote_state" "ec2" {
  backend = "s3"

  config = {
    bucket = var.remote_state_bucket
    key    = "ec2/terraform.tfstate"
    region = var.region
  }
}

module "eks" {
  source = "../../../modules/eks"

  cluster_name               = var.cluster_name
  kubernetes_version         = var.kubernetes_version
  cluster_role_arn           = data.terraform_remote_state.iam.outputs.role_arn
  subnet_ids                 = data.terraform_remote_state.vpc.outputs.private_subnet_ids
  security_group_ids         = [data.terraform_remote_state.sg.outputs.eks_security_group_id]
  endpoint_private_access    = var.endpoint_private_access
  endpoint_public_access     = var.endpoint_public_access
  access_entry_principal_arn = data.terraform_remote_state.ec2.outputs.role_arn
  tags                       = var.tags
}

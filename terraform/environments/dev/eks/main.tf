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

module "eks" {
  source = "../../../modules/eks"

  cluster_name               = var.cluster_name
  kubernetes_version         = var.kubernetes_version
  cluster_role_arn           = data.terraform_remote_state.iam.outputs.role_arn
  subnet_ids                 = data.terraform_remote_state.vpc.outputs.private_subnet_ids
  security_group_ids         = [data.terraform_remote_state.sg.outputs.eks_security_group_id]
  endpoint_private_access    = var.endpoint_private_access
  endpoint_public_access     = var.endpoint_public_access
  tags                       = var.tags

  node_group_name     = var.node_group_name
  node_role_arn       = data.terraform_remote_state.iam.outputs.node_role_arn
  node_subnet_ids     = data.terraform_remote_state.vpc.outputs.private_subnet_ids
  node_capacity_type  = var.node_capacity_type
  node_ami_type       = var.node_ami_type
  node_instance_types = var.node_instance_types
  node_disk_size      = var.node_disk_size
  node_desired_size   = var.node_desired_size
  node_min_size       = var.node_min_size
  node_max_size       = var.node_max_size
  node_labels         = var.node_labels
}

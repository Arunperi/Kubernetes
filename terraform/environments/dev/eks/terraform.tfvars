region = "us-east-1"
cluster_name       = "dev-eks"
kubernetes_version = "1.34"

endpoint_private_access = true
endpoint_public_access  = false

remote_state_bucket = "dev-tfstate-files-251119972"
vpc_state_key       = "vpc/terraform.tfstate"
iam_state_key       = "iam/terraform.tfstate"

tags = {
  Environment = "dev"
  Project     = "arun"
}

node_group_name     = "dev-eks-nodes"
node_capacity_type  = "ON_DEMAND"
node_ami_type       = "AL2023_x86_64_STANDARD"
node_instance_types = ["t3.medium"]
node_disk_size      = 20
node_desired_size   = 2
node_min_size       = 1
node_max_size       = 3
node_labels         = {}

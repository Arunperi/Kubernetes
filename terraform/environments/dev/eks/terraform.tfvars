region = "us-east-1"
cluster_name       = "dev-eks"
kubernetes_version = "1.34"

endpoint_private_access = true
endpoint_public_access  = false

remote_state_bucket = "dev-tfstate-files-251119971"
vpc_state_key       = "vpc/terraform.tfstate"
iam_state_key       = "iam/terraform.tfstate"

tags = {
  Environment = "dev"
  Project     = "arun"
}

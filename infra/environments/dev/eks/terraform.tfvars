region = "us-east-1"
cluster_name       = "dev-eks"
kubernetes_version = "1.33"

endpoint_private_access = true
endpoint_public_access  = true

remote_state_bucket = "dev-tfstate-files-32343"
vpc_state_key       = "vpc/terraform.tfstate"
iam_state_key       = "iam/terraform.tfstate"

tags = {
  Environment = "dev"
  Project     = "arun"
}

region = "us-east-1"

instance_name = "dev-eks-bastion"
instance_type = "t3.micro"
enable_ssh    = false

allowed_ssh_cidr = "0.0.0.0/0"

remote_state_bucket = "dev-tfstate-files-32343"
vpc_state_key       = "vpc/terraform.tfstate"
eks_state_key       = "eks/terraform.tfstate"

tags = {
  Environment = "dev"
  Project     = "arun"
}

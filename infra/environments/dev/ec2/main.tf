data "terraform_remote_state" "vpc" {
  backend = "s3"

  config = {
    bucket = var.remote_state_bucket
    key    = var.vpc_state_key
    region = var.region
  }
}

data "terraform_remote_state" "eks" {
  backend = "s3"

  config = {
    bucket = var.remote_state_bucket
    key    = var.eks_state_key
    region = var.region
  }
}

data "aws_ami" "amazon_linux_2023" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-2023.*-x86_64"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

module "ec2_bastion" {
  source = "../../../modules/ec2"

  name             = var.instance_name
  ami_id           = data.aws_ami.amazon_linux_2023.id
  instance_type    = var.instance_type
  subnet_id        = data.terraform_remote_state.vpc.outputs.public_subnet_ids[0]
  vpc_id           = data.terraform_remote_state.vpc.outputs.vpc_id
  key_name         = var.key_name
  allowed_ssh_cidr = var.allowed_ssh_cidr

  managed_policy_arns = [
    "arn:aws:iam::aws:policy/AmazonEKSReadOnlyAccess",
    "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
  ]

  user_data = <<-EOF
              #!/bin/bash
              set -euxo pipefail

              dnf update -y
              dnf install -y curl unzip awscli

              curl -LO "https://dl.k8s.io/release/v1.30.0/bin/linux/amd64/kubectl"
              install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
              rm -f kubectl

              su - ec2-user -c "aws eks update-kubeconfig --region ${var.region} --name ${data.terraform_remote_state.eks.outputs.cluster_name}"
              EOF

  tags = var.tags
}

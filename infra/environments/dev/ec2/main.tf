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
  enable_ssh       = var.enable_ssh

  managed_policy_arns = [
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

              for i in {1..20}; do
                if aws eks describe-cluster --region ${var.region} --name ${data.terraform_remote_state.eks.outputs.cluster_name} >/dev/null 2>&1; then
                  break
                fi
                sleep 15
              done

              su - ec2-user -c "aws eks update-kubeconfig --region ${var.region} --name ${data.terraform_remote_state.eks.outputs.cluster_name}"
              EOF

  tags = var.tags
}

resource "aws_iam_role_policy" "bastion_eks_describe_cluster" {
  name = "${var.instance_name}-eks-describe-cluster"
  role = module.ec2_bastion.iam_role_name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "eks:DescribeCluster"
        ]
        Resource = data.terraform_remote_state.eks.outputs.cluster_arn
      }
    ]
  })
}

data "aws_iam_role" "bastion" {
  name       = module.ec2_bastion.iam_role_name
  depends_on = [module.ec2_bastion]
}

resource "aws_eks_access_entry" "bastion" {
  cluster_name  = data.terraform_remote_state.eks.outputs.cluster_name
  principal_arn = data.aws_iam_role.bastion.arn
  type          = "STANDARD"
}

resource "aws_eks_access_policy_association" "bastion_cluster_admin" {
  cluster_name  = data.terraform_remote_state.eks.outputs.cluster_name
  principal_arn = data.aws_iam_role.bastion.arn
  policy_arn    = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"

  access_scope {
    type = "cluster"
  }

  depends_on = [aws_eks_access_entry.bastion]
}

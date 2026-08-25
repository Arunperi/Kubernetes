resource "aws_eks_cluster" "this" {
  name     = var.cluster_name
  role_arn = var.cluster_role_arn
  version  = var.kubernetes_version

  access_config {
    authentication_mode = "API"
  }

  vpc_config {
    subnet_ids              = var.subnet_ids
    security_group_ids      = var.security_group_ids
    endpoint_private_access = var.endpoint_private_access
    endpoint_public_access  = var.endpoint_public_access
  }

  tags = merge(var.tags, {
    Name = var.cluster_name
  })
}

resource "aws_eks_access_entry" "ec2_ssm_role" {
  cluster_name      = aws_eks_cluster.this.name
  principal_arn     = var.access_entry_principal_arn
  type              = "STANDARD"
  depends_on        = [aws_eks_cluster.this]
}

resource "aws_eks_access_policy_association" "ec2_ssm_role_admin" {
  cluster_name  = aws_eks_cluster.this.name
  principal_arn = aws_eks_access_entry.ec2_ssm_role.principal_arn
  policy_arn    = var.cluster_admin_policy_arn

  access_scope {
    type = "cluster"
  }

  depends_on = [aws_eks_access_entry.ec2_ssm_role]
}

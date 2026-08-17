output "role_name" {
  description = "EKS cluster role name"
  value       = module.eks_cluster_role.role_name
}

output "role_arn" {
  description = "EKS cluster role ARN"
  value       = module.eks_cluster_role.role_arn
}

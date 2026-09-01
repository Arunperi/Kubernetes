output "role_name" {
  description = "EKS cluster role name"
  value       = module.eks_cluster_role.role_name
}

output "role_arn" {
  description = "EKS cluster role ARN"
  value       = module.eks_cluster_role.role_arn
}

output "node_role_name" {
  description = "EKS node group role name"
  value       = module.eks_node_role.role_name
}

output "node_role_arn" {
  description = "EKS node group role ARN"
  value       = module.eks_node_role.role_arn
}

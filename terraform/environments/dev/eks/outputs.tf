output "cluster_name" {
  description = "EKS cluster name"
  value       = module.eks.cluster_name
}

output "cluster_arn" {
  description = "EKS cluster ARN"
  value       = module.eks.cluster_arn
}

output "cluster_endpoint" {
  description = "EKS endpoint"
  value       = module.eks.cluster_endpoint
}

output "node_group_name" {
  description = "EKS node group name"
  value       = module.eks.node_group_name
}

output "node_group_arn" {
  description = "EKS node group ARN"
  value       = module.eks.node_group_arn
}

output "node_group_status" {
  description = "EKS node group status"
  value       = module.eks.node_group_status
}

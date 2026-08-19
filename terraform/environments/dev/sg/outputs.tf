output "ec2_security_group_id" {
  description = "ID of the EC2 security group."
  value       = module.ec2_security_group.security_group_id
}

output "eks_security_group_id" {
  description = "ID of the EKS security group."
  value       = module.eks_security_group.security_group_id
}
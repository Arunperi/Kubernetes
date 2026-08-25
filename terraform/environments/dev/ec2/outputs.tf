output "role_arn" {
  description = "ARN of the EC2 SSM IAM role"
  value       = module.ec2.role_arn
}

output "role_name" {
  description = "Name of the EC2 SSM IAM role"
  value       = module.ec2.role_name
}

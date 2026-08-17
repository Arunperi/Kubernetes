output "vpc_id" {
  description = "ID of the VPC"
  value       = module.aws_vpc.vpc_id
}

output "public_subnet_ids" {
  description = "Public subnet IDs"
  value       = module.aws_vpc.public_subnet_ids
}

output "private_subnet_ids" {
  description = "Private subnet IDs"
  value       = module.aws_vpc.private_subnet_ids
}

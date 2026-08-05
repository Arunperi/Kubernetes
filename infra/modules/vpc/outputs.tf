output "vpc_id" {
  description = "ID of the VPC"
  value       = aws_vpc.this.id
}

output "public_subnet_ids" {
  description = "Public subnet IDs"
  value       = [for k, s in aws_subnet.this : s.id if local.subnet_config[k].is_public]
}

output "private_subnet_ids" {
  description = "Private subnet IDs"
  value       = [for k, s in aws_subnet.this : s.id if !local.subnet_config[k].is_public]
}

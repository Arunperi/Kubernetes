output "instance_id" {
  description = "Bastion EC2 instance ID"
  value       = module.ec2_bastion.instance_id
}

output "public_ip" {
  description = "Bastion public IP"
  value       = module.ec2_bastion.public_ip
}

output "public_dns" {
  description = "Bastion public DNS"
  value       = module.ec2_bastion.public_dns
}

output "security_group_id" {
  description = "Bastion security group ID"
  value       = module.ec2_bastion.security_group_id
}

output "ssh_command" {
  description = "SSH command to connect to bastion"
  value       = "ssh -i <path-to-private-key> ec2-user@${module.ec2_bastion.public_ip}"
}

output "kubeconfig_command_on_bastion" {
  description = "Run this command on bastion to refresh kubeconfig"
  value       = "aws eks update-kubeconfig --region ${var.region} --name ${data.terraform_remote_state.eks.outputs.cluster_name}"
}

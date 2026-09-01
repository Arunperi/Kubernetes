variable "region" {
  description = "AWS region where the security groups are created."
  type        = string
}

variable "remote_state_bucket" {
  description = "S3 bucket that stores the VPC Terraform state."
  type        = string
  default     = "dev-tfstate-files-251119972"
}

variable "vpc_state_key" {
  description = "S3 object key for the VPC Terraform state."
  type        = string
  default     = "vpc/terraform.tfstate"
}

variable "ec2_sg_name" {
  description = "Name of the EC2 security group."
  type        = string
}

variable "ec2_from_port" {
  description = "Starting port for EC2 ingress traffic."
  type        = number
}

variable "ec2_ip_protocol" {
  description = "IP protocol for EC2 ingress traffic."
  type        = string
}

variable "ec2_to_port" {
  description = "Ending port for EC2 ingress traffic."
  type        = number
}

variable "ec2_cidr_ipv4" {
  description = "IPv4 CIDR range allowed to SSH into EC2."
  type        = string
  default     = "0.0.0.0/0"
}

variable "ec2_egress_from_port" {
  description = "Starting port for EC2 outbound traffic."
  type        = number
}

variable "ec2_egress_to_port" {
  description = "Ending port for EC2 outbound traffic."
  type        = number
}

variable "ec2_egress_ip_protocol" {
  description = "IP protocol for EC2 outbound traffic."
  type        = string
}

variable "ec2_egress_cidr_ipv4" {
  description = "IPv4 CIDR destination for EC2 outbound traffic."
  type        = string
}

variable "eks_sg_name" {
  description = "Name of the EKS security group."
  type        = string
}

variable "eks_from_port" {
  description = "Starting port for EKS ingress traffic."
  type        = number
}

variable "eks_ip_protocol" {
  description = "IP protocol for EKS ingress traffic."
  type        = string
}

variable "eks_to_port" {
  description = "Ending port for EKS ingress traffic."
  type        = number
}

variable "eks_egress_from_port" {
  description = "Starting port for EKS outbound traffic."
  type        = number
}

variable "eks_egress_to_port" {
  description = "Ending port for EKS outbound traffic."
  type        = number
}

variable "eks_egress_ip_protocol" {
  description = "IP protocol for EKS outbound traffic."
  type        = string
}

variable "eks_egress_cidr_ipv4" {
  description = "IPv4 CIDR destination for EKS outbound traffic."
  type        = string
}



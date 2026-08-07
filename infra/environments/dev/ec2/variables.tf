variable "region" {
  description = "AWS region"
  type        = string
}

variable "instance_name" {
  description = "Bastion EC2 instance name"
  type        = string
  default     = "dev-eks-bastion"
}

variable "instance_type" {
  description = "Bastion EC2 instance type"
  type        = string
  default     = "t3.micro"
}

variable "key_name" {
  description = "Existing EC2 key pair name for SSH"
  type        = string
}

variable "allowed_ssh_cidr" {
  description = "CIDR block that can SSH to bastion"
  type        = string
  default     = "0.0.0.0/0"
}

variable "remote_state_bucket" {
  description = "S3 bucket storing Terraform states"
  type        = string
  default     = "dev-tfstate-files-32343"
}

variable "vpc_state_key" {
  description = "S3 key for VPC terraform state"
  type        = string
  default     = "vpc/terraform.tfstate"
}

variable "eks_state_key" {
  description = "S3 key for EKS terraform state"
  type        = string
  default     = "eks/terraform.tfstate"
}

variable "tags" {
  description = "Tags for EC2 resources"
  type        = map(string)
  default     = {}
}

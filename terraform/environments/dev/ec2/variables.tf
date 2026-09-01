variable "region" {
  description = "AWS region where the EC2 instance is created."
  type        = string
}

variable "instance_name" {
  description = "Name of the EC2 instance."
  type        = string
  default     = "dev-ec2"
}

variable "remote_state_bucket" {
  description = "S3 bucket that stores the VPC and security-group Terraform states."
  type        = string
  default     = "dev-tfstate-files-251119972"
}

variable "vpc_state_key" {
  description = "S3 object key for the VPC Terraform state."
  type        = string
  default     = "vpc/terraform.tfstate"
}

variable "sg_state_key" {
  description = "S3 object key for the security-group Terraform state."
  type        = string
  default     = "sg/terraform.tfstate"
}

variable "instance_type" {
  description = "EC2 instance type."
  type        = string
  default     = "t2.medium"
}



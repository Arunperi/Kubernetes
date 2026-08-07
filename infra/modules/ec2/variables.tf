variable "name" {
  description = "Name tag for EC2 instance"
  type        = string
}

variable "ami_id" {
  description = "AMI ID for EC2 instance"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
}

variable "subnet_id" {
  description = "Subnet ID where instance will be deployed"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID used for security group"
  type        = string
}

variable "key_name" {
  description = "Existing EC2 key pair name"
  type        = string
}

variable "allowed_ssh_cidr" {
  description = "CIDR block allowed to SSH to the instance"
  type        = string
}

variable "managed_policy_arns" {
  description = "Managed IAM policies attached to EC2 role"
  type        = list(string)
  default     = []
}

variable "user_data" {
  description = "User data script"
  type        = string
  default     = ""
}

variable "tags" {
  description = "Tags for EC2 resources"
  type        = map(string)
  default     = {}
}

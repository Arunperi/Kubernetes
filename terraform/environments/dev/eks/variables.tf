variable "region" {
  description = "AWS region"
  type        = string
}

variable "cluster_name" {
  description = "EKS cluster name"
  type        = string
}

variable "kubernetes_version" {
  description = "Kubernetes version for EKS"
  type        = string
  default     = "1.34"
}

variable "endpoint_private_access" {
  description = "Enable private EKS endpoint"
  type        = bool
  default     = true
}

variable "endpoint_public_access" {
  description = "Enable public EKS endpoint"
  type        = bool
  default     = false
}

variable "remote_state_bucket" {
  description = "S3 bucket that stores Terraform states"
  type        = string
  default     = "dev-tfstate-files-251119972"
}

variable "vpc_state_key" {
  description = "S3 key for VPC terraform state"
  type        = string
  default     = "vpc/terraform.tfstate"
}

variable "iam_state_key" {
  description = "S3 key for IAM terraform state"
  type        = string
  default     = "iam/terraform.tfstate"
}

variable "sg_state_key" {
  description = "S3 key for security-group Terraform state."
  type        = string
  default     = "sg/terraform.tfstate"
}

variable "tags" {
  description = "Tags for EKS resources"
  type        = map(string)
  default     = {}
}

variable "node_group_name" {
  description = "Name of the EKS managed node group"
  type        = string
  default     = "dev-eks-nodes"
}

variable "node_capacity_type" {
  description = "Type of capacity for the node group (ON_DEMAND or SPOT)"
  type        = string
  default     = "ON_DEMAND"
}

variable "node_ami_type" {
  description = "AMI type for the node group"
  type        = string
  default     = "AL2023_x86_64_STANDARD"
}

variable "node_instance_types" {
  description = "EC2 instance types for the node group"
  type        = list(string)
  default     = ["t3.medium"]
}

variable "node_disk_size" {
  description = "Disk size (GiB) for each node"
  type        = number
  default     = 20
}

variable "node_desired_size" {
  description = "Desired number of worker nodes"
  type        = number
  default     = 2
}

variable "node_min_size" {
  description = "Minimum number of worker nodes"
  type        = number
  default     = 1
}

variable "node_max_size" {
  description = "Maximum number of worker nodes"
  type        = number
  default     = 3
}

variable "node_labels" {
  description = "Kubernetes labels to apply to the node group"
  type        = map(string)
  default     = {}
}

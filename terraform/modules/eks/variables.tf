variable "cluster_name" {
  description = "EKS cluster name"
  type        = string
}

variable "kubernetes_version" {
  description = "Kubernetes version for EKS"
  type        = string
  default     = "1.34"
}

variable "cluster_role_arn" {
  description = "IAM role ARN used by EKS control plane"
  type        = string
}

variable "subnet_ids" {
  description = "Subnet IDs used by EKS cluster"
  type        = list(string)

  validation {
    condition     = length(var.subnet_ids) >= 2
    error_message = "Provide at least two subnet IDs across AZs for EKS."
  }
}

variable "security_group_ids" {
  description = "Security groups attached to the EKS cluster network interface."
  type        = list(string)
}

variable "endpoint_private_access" {
  description = "Whether the Amazon EKS private API server endpoint is enabled"
  type        = bool
  default     = true
}

variable "endpoint_public_access" {
  description = "Whether the Amazon EKS public API server endpoint is enabled"
  type        = bool
  default     = true
}


variable "tags" {
  description = "Tags to apply to the EKS cluster"
  type        = map(string)
  default     = {}
}

variable "node_group_name" {
  description = "Name of the EKS managed node group"
  type        = string
}

variable "node_role_arn" {
  description = "IAM role ARN used by the EKS worker nodes"
  type        = string
}

variable "node_subnet_ids" {
  description = "Subnet IDs used by the EKS node group"
  type        = list(string)
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

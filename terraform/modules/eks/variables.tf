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

variable "access_entry_principal_arn" {
  description = "IAM principal ARN that should be granted access to the EKS cluster"
  type        = string
}

variable "cluster_admin_policy_arn" {
  description = "EKS cluster access policy to attach to the principal"
  type        = string
  default     = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"
}

variable "tags" {
  description = "Tags to apply to the EKS cluster"
  type        = map(string)
  default     = {}
}

variable "cluster_name" {
  description = "EKS cluster name"
  type        = string
}

variable "kubernetes_version" {
  description = "Kubernetes version for EKS"
  type        = string
  default     = "1.30"
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

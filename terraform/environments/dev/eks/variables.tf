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
  default     = "dev-tfstate-files-25111997"
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

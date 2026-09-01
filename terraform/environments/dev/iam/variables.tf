variable "aws_region" {
    description = "AWS region"
    type        = string
}

variable "cluster_role_name" {
    description = "Role name"
    type = string
}

variable "cluster_assume_role_policy" {
    description = "Trust policy"
    type = string
}

variable "cluster_manages_policy_arns" {
    description = "AWS Manages Policies"
    type = list(string)
    default = []
}

variable "node_role_name" {
    description = "Role name"
    type = string
}

variable "node_assume_role_policy" {
    description = "Trust policy"
    type = string
}

variable "node_manages_policy_arns" {
    description = "AWS Manages Policies"
    type = list(string)
    default = []
}
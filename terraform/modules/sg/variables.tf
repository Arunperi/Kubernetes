variable "name" {
  description = "security group name"
  type = string
}

variable "vpc_id" {
  description = "VPC id"
  type = string
}

variable "from_port" {
  description = "from port"
  type = number
}

variable "ip_protocol" {
  description = "ip protocal"
  type = string
}

variable "to_port" {
  description = "Ending port for the ingress rule."
  type        = number
}

variable "cidr_ipv4" {
  description = "IPv4 CIDR range allowed to access the security group."
  type        = string
  default     = null
}

variable "referenced_security_group_id" {
  description = "Security group allowed to access this security group."
  type        = string
  default     = null
}
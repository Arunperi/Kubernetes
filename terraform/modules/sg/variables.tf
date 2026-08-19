variable "name" {
  description = "security group name"
  type        = string
}

variable "vpc_id" {
  description = "VPC id"
  type        = string
}

variable "from_port" {
  description = "from port"
  type        = number
}

variable "ip_protocol" {
  description = "ip protocal"
  type        = string
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

variable "egress_from_port" {
  description = "Starting port for the egress rule."
  type        = number
  default     = 0
}

variable "egress_to_port" {
  description = "Ending port for the egress rule."
  type        = number
  default     = 0
}

variable "egress_ip_protocol" {
  description = "IP protocol for the egress rule."
  type        = string
  default     = "-1"
}

variable "egress_cidr_ipv4" {
  description = "IPv4 CIDR range allowed for outbound traffic."
  type        = string
  default     = "0.0.0.0/0"
}
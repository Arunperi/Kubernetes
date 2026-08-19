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
  description = "to port"
  type = number
}
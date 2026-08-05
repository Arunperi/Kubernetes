variable "cidr_block" {
    description = "VPC cidr_block"
    type = string
}

variable "vpc_name" {
    description = "VPC Name"
    type = string
}

variable "tags" {
    description = "Common tags to apply to VPC resources"
    type = map(string)
    default = {}
}

variable "subnet_count" {
    type = number

    validation {
        condition     = var.subnet_count >= length(var.availability_zones)
        error_message = "subnet_count must be at least the number of availability_zones."
    }

    validation {
        condition     = var.subnet_count <= 4
        error_message = "subnet_count cannot exceed 4 with the current cidrsubnet(var.cidr_block, 2, i) split."
    }
}

variable "availability_zones" {
    description = "Two availability zones for the subnets"
    type = list(string)

    validation {
        condition     = length(var.availability_zones) == 2
        error_message = "Provide exactly two availability zones."
    }
}
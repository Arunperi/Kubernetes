variable "region" {
    description = "VPC Region"
    type = string
}

variable "cidr_block" {
    description = "CIDR block for the VPC"
    type = string
}

variable "subnet_count" {
    description = "Number of subnets to create"
    type = number
    default = 4
}

variable "availability_zones" {
    description = "Two availability zones used to create four subnets"
    type = list(string)

    validation {
        condition     = length(var.availability_zones) == 2
        error_message = "Provide exactly two availability zones."
    }
}
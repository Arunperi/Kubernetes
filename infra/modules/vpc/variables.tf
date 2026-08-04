variable "cidr_block" {
    description = "VPC cidr_block"
    type = string
}

variable "subnet_count" {
    type = number
}

variable "availability_zones" {
    description = "Two availability zones for the subnets"
    type = list(string)

    validation {
        condition     = length(var.availability_zones) == 2
        error_message = "Provide exactly two availability zones."
    }
}
variable "name" {
    description = "ECR Repository Name"
    type = string
}

variable "image_tag_mutability" {
    description = "MUTABLE or IMMUTABLE"
    type = string
    default = "MUTABLE"
}
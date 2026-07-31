variable "aws_region" {
    description = "AWS Region"
    type = string
}

variable "backend_repo_name" {
    description = "ECR repository for backend"
    type = string
}

variable "frontend_repo_name" {
    description = "ECR repository for frontend"
    type = string
}

variable "image_tag_mutability" {
    description = "IMMUTABLE or MUTABLE"
    type = string
    default = "MUTABLE"
}
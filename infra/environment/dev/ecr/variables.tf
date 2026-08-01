variable "aws_region" {
    description = "AWS Region"
    type = string
}

variable "bucket_name" {
  description = "Backend S3 bucket name"
  type = string
}

variable "key" {
    description = "S3 object"
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
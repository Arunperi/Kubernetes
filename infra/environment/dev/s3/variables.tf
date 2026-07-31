variable "aws_region" {
    description = "AWS Region"
    type = string
}

variable "bucket_name" {
    description = "bucket name"
    type = string
}

variable "environment" {
  description = "Environment name"
  type        = string
}

variable "module_names" {
    type = list(string)
}
variable "role_name" {
    description = "Role name"
    type = string
}

variable "assume_role_policy" {
    description = "Trust policy"
    type = string
}

variable "manages_policy_arns" {
    description = "AWS Manages Policies"
    type = list(string)
    default = []
}
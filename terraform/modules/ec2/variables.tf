variable "ami" {
  description = "EC2 instance AMI Id"
  type = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type = string
}

variable "subnet_id" {
  description = "Subnet where the EC2 instance is launched"
  type = string
}

variable "ec2_ssh_sg" {
  description = "EC2 Security group for SSH"
  type = string
}
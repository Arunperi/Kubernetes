module "aws_vpc" {
    source = "../../../modules/vpc"
    cidr_block         = var.cidr_block
    subnet_count       = var.subnet_count
    availability_zones = var.availability_zones
}

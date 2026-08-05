module "aws_vpc" {
    source = "../../../modules/vpc"
    cidr_block         = var.cidr_block
    vpc_name           = var.vpc_name
    tags               = var.tags
    subnet_count       = var.subnet_count
    availability_zones = var.availability_zones
    
}

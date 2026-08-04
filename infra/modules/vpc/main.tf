resource "aws_vpc" "this" {
    cidr_block = var.cidr_block
}

locals {
  subnet_config = {
    for i in range(var.subnet_count) : "subnet_${i + 1}" => {
      cidr_block        = cidrsubnet(var.cidr_block, 2, i)
      availability_zone = var.availability_zones[i % length(var.availability_zones)]
    }
  }
}

resource "aws_subnet" "this" {
    for_each = local.subnet_config

    vpc_id                  = aws_vpc.this.id
    cidr_block              = each.value.cidr_block
    availability_zone       = each.value.availability_zone
    map_public_ip_on_launch = startswith(each.key, "public")
}
resource "aws_vpc" "this" {
    cidr_block = var.cidr_block
  tags = merge(var.tags, {
    Name = var.vpc_name
  })
}

resource "aws_internet_gateway" "this" {
    vpc_id = aws_vpc.this.id
    tags = merge(var.tags, {
      Name = "${var.vpc_name}-igw"
    })
}

locals {
  public_subnet_count = length(var.availability_zones)
  subnet_config = {
    for i in range(var.subnet_count) : "subnet_${i + 1}" => {
      cidr_block        = cidrsubnet(var.cidr_block, 2, i)
      availability_zone = var.availability_zones[i % length(var.availability_zones)]
      is_public         = i < local.public_subnet_count
    }
  }

  public_subnets  = { for k, v in local.subnet_config : k => v if v.is_public }
  private_subnets = { for k, v in local.subnet_config : k => v if !v.is_public }
}

resource "aws_subnet" "this" {
    for_each = local.subnet_config

    vpc_id                  = aws_vpc.this.id
    cidr_block              = each.value.cidr_block
    availability_zone       = each.value.availability_zone
    map_public_ip_on_launch = each.value.is_public
    tags = merge(var.tags, {
      Name = "${var.vpc_name}-${each.key}"
    })
}

resource "aws_eip" "nat" {
  for_each = local.public_subnets

  domain = "vpc"
  tags = merge(var.tags, {
    Name = "${var.vpc_name}-${each.key}-eip"
  })
}

resource "aws_nat_gateway" "this" {
  for_each = local.public_subnets

  allocation_id = aws_eip.nat[each.key].id
  subnet_id     = aws_subnet.this[each.key].id
  tags = merge(var.tags, {
    Name = "${var.vpc_name}-${each.key}-nat"
  })

  depends_on = [aws_internet_gateway.this]
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.this.id

  tags = merge(var.tags, {
    Name = "${var.vpc_name}-public-rt"
  })
}

resource "aws_route" "public_default" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.this.id
}

resource "aws_route_table_association" "public" {
  for_each = local.public_subnets

  subnet_id      = aws_subnet.this[each.key].id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table" "private" {
  for_each = local.private_subnets

  vpc_id = aws_vpc.this.id
  tags = merge(var.tags, {
    Name = "${var.vpc_name}-${each.key}-private-rt"
  })
}

resource "aws_route" "private_default" {
  for_each = local.private_subnets

  route_table_id         = aws_route_table.private[each.key].id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id = aws_nat_gateway.this[
    "subnet_${index(var.availability_zones, each.value.availability_zone) + 1}"
  ].id
}

resource "aws_route_table_association" "private" {
  for_each = local.private_subnets

  subnet_id      = aws_subnet.this[each.key].id
  route_table_id = aws_route_table.private[each.key].id
}
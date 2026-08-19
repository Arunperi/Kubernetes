resource "aws_security_group" "this" {
    name = var.name
    vpc_id = var.vpc_id
}

resource "aws_vpc_security_group_ingress_rule" "this" {
  security_group_id            = aws_security_group.this.id
  from_port                    = var.from_port
  ip_protocol                  = var.ip_protocol
  to_port                      = var.to_port
  cidr_ipv4                    = var.cidr_ipv4
  referenced_security_group_id = var.referenced_security_group_id
}
module "aws_security_group" {
  source = "../../../modules/sg"
  name = var.name
  vpc_id = var.vpc_id
  ip_protocol = var.ip_protocol
  from_port = var.from_port
  to_port = var.to_port
}
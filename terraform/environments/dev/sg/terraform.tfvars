region = "us-east-1"

ec2_sg_name     = "dev-ec2-sg"
ec2_cidr_ipv4   = "0.0.0.0/0"
ec2_ip_protocol = "tcp"
ec2_from_port   = 22
ec2_to_port     = 22

ec2_egress_ip_protocol = "-1"
ec2_egress_from_port   = 0
ec2_egress_to_port     = 0
ec2_egress_cidr_ipv4   = "0.0.0.0/0"

eks_sg_name     = "dev-eks-sg"
eks_ip_protocol = "tcp"
eks_from_port   = 443
eks_to_port     = 443

eks_egress_ip_protocol = "-1"
eks_egress_from_port   = 0
eks_egress_to_port     = 0
eks_egress_cidr_ipv4   = "0.0.0.0/0"

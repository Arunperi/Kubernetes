region = "us-east-1"

ec2_sg_name     = "dev-ec2-sg"
ec2_cidr_ipv4   = "0.0.0.0/0"
ec2_ip_protocol = "tcp"
ec2_from_port   = 22
ec2_to_port     = 22

eks_sg_name     = "dev-eks-sg"
eks_ip_protocol = "tcp"
eks_from_port   = 443
eks_to_port     = 443

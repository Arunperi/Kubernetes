region = "us-east-1"
cidr_block = "10.0.0.0/16"
vpc_name = "dev-vpc"
tags = {
	Environment = "dev"
	Project     = "arun"
}
subnet_count = 4
availability_zones = ["us-east-1a","us-east-1b"] 
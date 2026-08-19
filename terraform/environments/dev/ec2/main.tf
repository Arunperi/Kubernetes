data "terraform_remote_state" "vpc" {
  backend = "s3"

  config = {
    bucket = var.remote_state_bucket
    key    = var.vpc_state_key
    region = var.region
  }
}

data "terraform_remote_state" "sg" {
  backend = "s3"

  config = {
    bucket = var.remote_state_bucket
    key    = var.sg_state_key
    region = var.region
  }
}

data "aws_ssm_parameter" "amazon_linux_2023_ami" {
  name = "/aws/service/ami-amazon-linux-latest/al2023-ami-kernel-default-x86_64"
}

module "ec2" {
  source = "../../../modules/ec2"

  instance_name = var.instance_name
  ami           = data.aws_ssm_parameter.amazon_linux_2023_ami.value
  instance_type = var.instance_type
  subnet_id     = data.terraform_remote_state.vpc.outputs.public_subnet_ids[0]
  ec2_ssh_sg    = data.terraform_remote_state.sg.outputs.ec2_security_group_id
}

resource "aws_instance" "this" {
  ami = var.ami
  instance_type = var.instance_type

  tags = {
    Name = "dev-ec2"
  }

  subnet_id = var.subnet_id
  associate_public_ip_address = true
  security_groups = [ var.ec2_ssh_sg ]
}
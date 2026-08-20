resource "aws_iam_role" "ssm" {
  name = "${var.instance_name}-ssm-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
      Action = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_role_policy_attachment" "ssm" {
  role       = aws_iam_role.ssm.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

resource "aws_iam_role_policy_attachment" "administrator_access" {
  role       = aws_iam_role.ssm.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

resource "aws_iam_instance_profile" "this" {
  name = "${var.instance_name}-profile"
  role = aws_iam_role.ssm.name
}

resource "aws_instance" "this" {
  ami                    = var.ami
  instance_type          = var.instance_type
  iam_instance_profile   = aws_iam_instance_profile.this.name
  subnet_id              = var.subnet_id
  vpc_security_group_ids = [var.ec2_ssh_sg]

  associate_public_ip_address = true

  user_data = <<-EOF
    #!/bin/bash
    set -euo pipefail

    dnf install -y curl
    KARCH="amd64"
    KVER=$(curl -L -s https://dl.k8s.io/release/stable.txt)

    cd /tmp
    curl -LO "https://dl.k8s.io/release/$${KVER}/bin/linux/$${KARCH}/kubectl"
    curl -LO "https://dl.k8s.io/release/$${KVER}/bin/linux/$${KARCH}/kubectl.sha256"
    echo "$(cat kubectl.sha256)  kubectl" | sha256sum --check
    install -m 0755 kubectl /usr/local/bin/kubectl
  EOF

  tags = {
    Name = var.instance_name
  }
}

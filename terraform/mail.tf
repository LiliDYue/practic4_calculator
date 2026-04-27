provider "aws" {
  region = "us-east-1"
}

# Security Group (abrimos puertos necesarios)
resource "aws_security_group" "k3s_sg" {
  name = "k3s-security-group"

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "App NodePort"
    from_port   = 30007
    to_port     = 30007
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Kubernetes API"
    from_port   = 6443
    to_port     = 6443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# EC2 con K3s
resource "aws_instance" "k3s" {
  ami           = "ami-0fc5d935ebf8bc3bc"
  instance_type = "t3.small"
  key_name      = "k3s-key"

  vpc_security_group_ids = [aws_security_group.k3s_sg.id]

  user_data = <<-EOF
              #!/bin/bash
              apt update -y
              curl -sfL https://get.k3s.io | sudo sh -
              EOF

  tags = {
    Name = "k3s-cluster"
  }
}

# IP pública
output "public_ip" {
  value = aws_instance.k3s.public_ip
}
provider "aws" {
  region = "us-east-1"
}

terraform {
  backend "s3" {
    bucket = "your-terraform-state-bucket1998"
    key    = "terraform.tfstate"
    region = "us-east-1"
  }
}

variable "key_name" {}

resource "aws_instance" "app_server" {
  ami             = "ami-085ad6ae776d8f09c"
  instance_type   = "t3.micro"
  key_name        = var.key_name
  security_groups = [aws_security_group.project_sg.name]

  connection {
    type        = "ssh"
    user        = "ec2-user"
    private_key = file("/var/lib/jenkins/.ssh/var.key_name.pem")
    host        = self.public_ip
  }

  provisioner "remote-exec" {
    inline = [
      "sudo yum update -y",
      "sudo yum install git -y",
      "sudo yum install maven -y",
      "sudo yum install docker -y",
      "sudo yum install java-11-openjdk -y",
      "sudo systemctl start docker",
      "sudo systemctl enable docker"
    ]
  }

  tags = {
    Name = "Terraform-EC2"
  }
}

resource "aws_security_group" "project_sg" {
  name        = "project"
  description = "Allow SSH and web traffic"
  
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

output "instance_public_ip" {
  value = aws_instance.app_server.public_ip
}

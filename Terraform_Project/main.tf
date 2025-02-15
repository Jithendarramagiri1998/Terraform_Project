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

resource "aws_instance" "app_server" {
  ami             = "ami-085ad6ae776d8f09c" # Replace with your preferred AMI
  instance_type   = "t3.micro"
  key_name        = "var.key_name"
  security_groups = ["project"]

  # SSH Connection Configuration
  connection {
    type        = "ssh"
    user        = "ec2-user"   # For Amazon Linux, use "ubuntu" for Ubuntu instances
    private_key = file("C:/Users/ramag/Downloads/var.key_name.pem") # Corrected Path
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

output "instance_public_ip" {
  value = aws_instance.app_server.public_ip
}

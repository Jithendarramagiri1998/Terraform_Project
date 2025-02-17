provider "aws" {
  region = "us-east-1"
}

terraform {
  backend "s3" {
    bucket = "balll"
    key    = "terraform.tfstate"
    region = "us-east-1"
  }
}

resource "aws_instance" "app_server" {
  ami             = "ami-053a45fff0a704a47" # Replace with a valid AMI
  instance_type   = "t2.micro"
  key_name        = "var.key_name"
  vpc_security_group_ids = ["sg-052f7fa9e79faa1f0"]

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

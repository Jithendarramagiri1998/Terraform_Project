#!/bin/bash

# Update and install Docker
sudo yum update -y
sudo yum install -y docker
sudo systemctl start docker
sudo systemctl enable docker

# Run Tomcat container
sudo docker run -d -p 8080:8080 tomcat:9.0


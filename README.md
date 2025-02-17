# Terraform Automated Deployment with Jenkins

## Overview
This project automates the deployment of an AWS EC2 instance, installs necessary dependencies, and deploys a Tomcat container using Terraform, Docker, and Jenkins. The entire process is fully automated, ensuring no manual intervention is required.

## Project Components
1. **Terraform** - Provisions the EC2 instance.
2. **Docker** - Runs a Tomcat container.
3. **GitHub** - Stores Terraform scripts, Jenkins pipeline, and Docker files.
4. **Jenkins** - Automates the deployment workflow.

## Prerequisites
Before proceeding, ensure you have the following:
- AWS account with IAM access.
- Terraform installed (`terraform --version`).
- Jenkins installed with required plugins (Pipeline, Git, AWS CLI, etc.).
- GitHub repository access.

## Setup Instructions

### Step 1: Clone the Repository
```bash
git clone https://github.com/your-username/Terraform_Automation.git
cd Terraform_Automation
```

### Step 2: Configure Terraform Backend (Optional)
Modify `main.tf` to update the S3 backend for Terraform state storage:
```hcl
terraform {
  backend "s3" {
    bucket = "your-terraform-state-bucket"
    key    = "terraform.tfstate"
    region = "us-east-1"
  }
}
```

### Step 3: Initialize and Apply Terraform
```bash
terraform init
terraform apply -auto-approve
```
- This will create an EC2 instance and install required dependencies (Git, Maven, Docker, Java, etc.).

### Step 4: Deploy Tomcat Container
```bash
bash deploy.sh
```
- This script will pull the Tomcat image and run it inside a container on the EC2 instance.

### Step 5: Access the Application
- Once the deployment is complete, find the **EC2 Public IP** in the Terraform output.
- Open a browser and navigate to:
  ```
  http://<instance-public-ip>:8080
  ```

## Jenkins Automation
### Pipeline Configuration
1. Open Jenkins → **New Item** → Select **Pipeline**.
2. In **Pipeline Script from SCM**, select **Git**.
3. Add Repository URL:
   ```
   https://github.com/your-username/Terraform_Automation.git
   ```
4. Choose **Branch: `main`**.
5. Set **Script Path: `Jenkinsfile`**.
6. Click **Save & Build Now**.

### Expected Output
- Jenkins will automatically execute Terraform and deploy the Tomcat container.
- The **public IP of the instance** will be displayed in the **Jenkins console output**.
- The Tomcat container will be accessible at `http://<instance-public-ip>:8080`.

## Repository Structure
```
/Terraform_Automation
    ├── main.tf         # Terraform script to provision EC2
    ├── Dockerfile      # Tomcat container setup
    ├── deploy.sh       # Deployment automation script
    ├── Jenkinsfile     # Jenkins pipeline script
    ├── README.md       # Documentation
```

## Conclusion
This project ensures a **fully automated deployment pipeline** using Terraform, Docker, and Jenkins. No manual intervention is required, and the infrastructure is provisioned dynamically.

If you have any questions or need modifications, feel free to open an issue on GitHub!


# Access-S3-Public-Private-Endpoint---Terraform-Jenkins-Automated-pipeline

Access S3 Public Private Endpoint - Terraform
This project demonstrates the creation of AWS infrastructure using Terraform to access an S3 bucket from EC2 instances in both public and private subnets. The architecture is designed to securely route traffic through endpoints, allowing both public and private access to an S3 bucket.

Architecture Overview
The architecture comprises the following components:

VPC with two subnets: one public and one private.
Bastion EC2 Instance in the public subnet with a public IP.
Private EC2 Instance in the private subnet without a public IP.
S3 Bucket with access via both public and private endpoints.
NAT Gateway to allow internet access for the private EC2 instance if needed.
VPC Endpoint to enable private access to S3 from within the private subnet.

Prerequisites
Terraform version 1.5.0 or later
AWS Account with the necessary permissions to create resources (VPC, EC2, S3, IAM)
Jenkins setup for continuous deployment (optional but recommended)
Getting Started
Step 1: Clone the Repository
First, clone the repository to your local machine:

bash
Copy code
git clone https://github.com/yourusername/access-s3-public-private-endpoint-terraform.git
cd access-s3-public-private-endpoint-terraform
Step 2: Configure Terraform Variables
In the project directory, edit the variables.tf file to configure your desired AWS region, VPC CIDR blocks, and other variables. Example:

hcl
Copy code
variable "aws_region" {
default = "us-east-1"
}

variable "vpc_cidr_block" {
default = "172.16.0.0/16"
}
Step 3: Initialize Terraform
Run the following command to initialize Terraform. This will download the necessary providers and set up the Terraform environment:

bash
Copy code
terraform init
Step 4: Review the Execution Plan
Run the following command to generate and review the execution plan:

bash
Copy code
terraform plan
This will show you what resources will be created and modified.

Step 5: Apply the Configuration
Once you've reviewed the plan, apply the changes to create the AWS infrastructure:

bash
Copy code
terraform apply
Step 6: Destroy the Infrastructure (Optional)
If you wish to tear down the infrastructure once you're done, you can use the following command:

bash
Copy code
terraform destroy
Jenkins Pipeline Automation
If you'd like to automate the deployment using Jenkins, follow the steps below:

Step 1: Push the Code to GitHub
Ensure your code is pushed to a GitHub repository for Jenkins to access.

bash
Copy code
git add .
git commit -m "Initial commit for Terraform S3 access"
git push origin main
Step 2: Create a Jenkins Pipeline
Create a Jenkins pipeline that performs the following steps:

Checkout the Terraform code from GitHub.
Run Terraform init, plan, and apply to deploy the infrastructure.
Use Jenkinsfile for pipeline automation (located in the root of the repository).
Here's a sample Jenkinsfile that can be used:

groovy
Copy code
pipeline {
agent any

    environment {
        TERRAFORM_VERSION = '1.5.0'
        GIT_CREDENTIALS_ID = 'github-credentials'
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }
        stage('Terraform Init') {
            steps {
                sh 'terraform init'
            }
        }
        stage('Terraform Plan') {
            steps {
                sh 'terraform plan -out=tfplan'
            }
        }
        stage('Terraform Apply') {
            steps {
                sh 'terraform apply tfplan'
            }
        }
        stage('Destroy') {
            when {
                expression { return params.DESTROY == true }
            }
            steps {
                sh 'terraform destroy -auto-approve'
            }
        }
    }

    post {
        always {
            echo "Pipeline completed!"
        }
    }

}

Step 3: Trigger Jenkins Pipeline
You can either manually trigger the pipeline from Jenkins or set up a webhook in GitHub to automatically trigger the pipeline when new commits are pushed to the repository.

Debugging and Troubleshooting
Here are some common debugging tips if things go wrong:

Terraform Init Issues:

Ensure that your AWS credentials are correctly configured.
Make sure you have the correct permissions to create VPC, EC2, and S3 resources.
EC2 Connection Issues:

Ensure the security groups allow inbound SSH traffic on port 22.
For private EC2, use the bastion host for SSH access.
S3 Access Issues:

Verify that your VPC endpoints are correctly configured to allow S3 access.
Ensure the IAM roles and policies attached to the EC2 instances grant the necessary S3 permissions.
Pipeline Failures:

Check the Jenkins console log for detailed errors.
Verify that the Terraform state files are properly managed in remote storage (S3) if you are using backend configuration.


Project Structure
plaintext
Copy code
├── main.tf # Main Terraform configuration
├── network.tf # VPC, Subnets, and Security Groups
├── ec2.tf # EC2 Instances (Public & Private)
├── s3.tf # S3 Bucket and VPC Endpoint
├── variables.tf # Variables used in the configuration
├── outputs.tf # Outputs like EC2 instance IP, S3 URL
├── Jenkinsfile # Jenkins pipeline script for automation
└── README.md # Project documentation


References
Terraform Documentation
AWS S3 Endpoints
Jenkins Documentation

License
This project is licensed under the MIT License.

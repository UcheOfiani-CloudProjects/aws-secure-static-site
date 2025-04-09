# Secure Static Site Deployment with Terraform

This project demonstrates how to deploy a secure static website using AWS S3, CloudFront, and Terraform. The website is hosted on Amazon S3 with CloudFront as the Content Delivery Network (CDN) for faster performance. We also automate the deployment process with Terraform, making it scalable and reproducible.

# Features
Deploy a static website on AWS S3.
Use CloudFront for a faster CDN (Content Delivery Network).
Secure access with an S3 bucket policy for restricted access.
No domain setup (optional).
Modular Terraform configuration.

# Prerequisites
Before running this project, make sure you have the following tools installed:
-Terraform: Install Terraform
-AWS CLI: Install AWS CLI
-AWS Account: Ensure you have an AWS account and have configured the AWS CLI with your credentials.

# Getting Started
-Clone the repository:

`git clone https://github.com/username/secure-static-site-terraform.git`

`cd secure-static-site-terraform`

# Initialize Terraform:
Initialize your Terraform configuration to download the required providers and modules.

`terraform init`

# Review the Terraform configuration:
Open the main.tf and cloudfront.tf files to review the configuration. You can adjust any settings such as bucket names, region, or resources as needed.

# Run Terraform plan:
Generate an execution plan to review the changes Terraform will make to your infrastructure.

`terraform plan`

# Apply the changes:
Apply the changes to create the AWS resources.

`terraform apply`

# Access your static site:
Once the terraform apply completes, Terraform will output the CloudFront URL where your static site is hosted. You can access it using this URL.

# Files
-main.tf: Contains the S3 bucket configuration and website deployment.
-cloudfront.tf: Contains the CloudFront distribution setup.
-variables.tf: Contains variables for S3 bucket name, region, etc.
-outputs.tf: Displays the URL of the CloudFront distribution.

# Resources
-Terraform Documentation
-AWS S3 Documentation
-AWS CloudFront Documentation

# License
This project is licensed under the MIT License - see the LICENSE file for details.
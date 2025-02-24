# Task 

Write an Infrastructure-as-Code (IaC) script using Terraform to provision AWS resources (EC2,
S3, RDS)

# Implementation

For this task, I will use AWS community modules in my Terraform script. DevOps is about efficiency, automation, and reducing manual overhead. There's no need to reinvent the wheel when well-maintained modules already exist to streamline infrastructure provisioning.

This repository contains Terraform configurations to provision AWS resources including an EC2 instance, an S3 bucket, and an RDS PostgreSQL database.

## Overview

This setup follows best practices by leveraging AWS community modules for efficient and automated infrastructure deployment. The infrastructure includes:

- EC2 Instance (Debian 12) with SSH, HTTP, and HTTPS access.

- S3 Bucket with versioning enabled and automatic deletion upon resource destruction.

- RDS PostgreSQL Instance secured with a dedicated security group, allowing access only from the EC2 instance.

## Prerequisites

Ensure you have the following installed:

- Terraform (>= 1.0)

- AWS CLI (configured with appropriate credentials)

## Usage

1. Clone the Repository

    ```sh
    git clone <repository_url>
    cd <repository_name>
    ```

2. Initialize Terraform

    ```sh
    terraform init
    ```

3. Plan the Deployment

    ```sh
    terraform plan
    ```

4. Apply the Configuration

    ```sh
    terraform apply -auto-approve
    ```

5. Retrieve RDS Master Password

    We need the master password to connect to our database and since `manage_master_user_password` is enabled, Terraform will not store the password in state files. Instead, retrieve it from AWS Secrets Manager:

    ```sh
    aws secretsmanager get-secret-value --secret-id $(terraform output -raw db_instance_master_user_secret_arn) --query SecretString --output text
    ```

    This command fetches the database password needed for connection.

6. Connect to the RDS Instance from EC2

    Once the infrastructure is deployed, SSH into the EC2 instance and connect to the PostgreSQL database:

    ```sh
    ssh -i <your-key.pem> admin@<ec2-public-ip>
    ```

    Then, on the EC2 instance:

    ```sh
    psql -h <rds-endpoint> -U nithubroot -d nithubDB
    ```

    You can retrieve the RDS endpoint from the terraform output after creating your infrastructure, this output will give you the RDS endpoint, which you can use to connect to the database.

## Cleanup

To destroy all resources, run:

```sh
terraform destroy -auto-approve
```

## Notes

- The EC2 and RDS instances are secured using dedicated security groups.

- The S3 bucket is set to force_destroy = true, meaning it will be deleted even if it contains objects.

- The RDS instance is configured without automatic backups (`skip_final_snapshot = true`).
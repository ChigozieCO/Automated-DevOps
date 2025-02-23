# Add the providers
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
    }
  }

  # Remote backend configuration
  backend "s3" {
    bucket = "nithub-infra"
    key    = "terraform.tfstate"
    region = "us-east-1"
    use_lockfile = true
  }
}

# Configure the AWS Provider
provider "aws" {
  region = var.region
  shared_credentials_files = ["~/.aws/credentials"]
}
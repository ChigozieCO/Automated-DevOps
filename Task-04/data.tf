# Get the current region
data "aws_region" "current" {}

# Grt the default VPC
data "aws_vpc" "default" {
  default = true
}

# Get the default subnet
data "aws_subnet" "default" {
  vpc_id = data.aws_vpc.default.id
  state  = "available"

  # This will pick one of the AZ's default subnet
  availability_zone = "${data.aws_region.current.name}c"
}

# Retrieve the AMI ID for Debian 12
data "aws_ami" "debian" {
  most_recent = true

  filter {
    name   = "name"
    values = ["debian-12-amd64-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["136693071363"] # Official Debian AWS account ID
}
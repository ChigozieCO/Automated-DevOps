# Create a security group with http, https and ssh access
module "web_server_sg" {
  source = "terraform-aws-modules/security-group/aws"
  name        = "nithub_sg"
  vpc_id      = data.aws_vpc.default.id
  ingress_cidr_blocks = ["0.0.0.0/0"]
  ingress_rules = [
    "http-80-tcp",
    "https-443-tcp",
    "ssh-tcp"
  ]
}

# Create an EC2 instance
module "ec2" {
  source = "terraform-aws-modules/ec2-instance/aws"
  name = "nithub-ec2"
  ami = data.aws_ami.debian.image_id
  instance_type = "t2.micro"
  key_name = "socktest" # Use the name of your existing key pair
  associate_public_ip_address = true
  vpc_security_group_ids = [module.web_server_sg.security_group_id]
  subnet_id = data.aws_subnet.default.id

  tags = {
    AMI_Name = "Debian12"
  }
}

# Create S3 Bucket
module "s3_bucket" {
  source = "terraform-aws-modules/s3-bucket/aws"

  bucket = "nithub-bucket"

  force_destroy = true

  versioning = {
    enabled = true
  }
}

# Create a security group for the RDS instance
module "rds_sg" {
  source = "terraform-aws-modules/security-group/aws"
  name        = "nithub_rds_sg"
  vpc_id      = data.aws_vpc.default.id
  
  # Allow PostgreSQL (port 5432) access ONLY from the EC2 security group
  ingress_with_source_security_group_id = [
    {
      rule                     = "postgresql-tcp"
      source_security_group_id = module.web_server_sg.security_group_id
    }
  ]
}

# Create RDS instance
module "rds" {
  source = "terraform-aws-modules/rds/aws"
  identifier = "nithub-rds"

  engine = "postgres"
  engine_version = "17.4"
  instance_class = "db.t3.micro"
  allocated_storage = 20
  storage_type = "gp2"

  db_name = "nithubDB"
  username = "nithubroot"
  manage_master_user_password = true
  skip_final_snapshot = true

  # Networking & Security
  vpc_security_group_ids = [module.rds_sg.security_group_id]  # Use the RDS security group

  # Disable option and parameter groups creation
  create_db_option_group    = false
  create_db_parameter_group = false
}
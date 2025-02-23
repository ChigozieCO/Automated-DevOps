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
    AMI_Name = "Debian12",
  }
}
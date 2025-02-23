output "public_ip" {
  description = "The public IP address of the EC2 instance"
  value       = module.ec2.public_ip
}

output "db_password_secret_name" {
  value = module.rds.db_instance_master_user_secret_arn
}
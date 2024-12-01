# Outputs file

output "vpc_id" {
  value = aws_vpc.main.id
  description = "VPC ID"
}

output "bastion_ec2_id" {
  value = aws_instance.bastion.id
  description = "ID of the Bastion EC2 instance"
}

output "private_ec2_id" {
  value = aws_instance.private_ec2.id
  description = "ID of the Private EC2 instance"
}

output "s3_bucket_name" {
  value = aws_s3_bucket.my_bucket.bucket
  description = "S3 Bucket Name"
}

output "static_website_url" {
  value = aws_s3_bucket_website_configuration.my_bucket_website.website_endpoint
}

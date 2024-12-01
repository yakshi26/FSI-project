# Create S3 VPC Endpoint for Private Subnet
resource "aws_vpc_endpoint" "s3_endpoint" {
  vpc_id       = aws_vpc.main.id
  service_name = "com.amazonaws.${var.region}.s3"

  route_table_ids = [aws_route_table.private_rt.id]
}

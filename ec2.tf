
# Bastion EC2 in Public Subnet
resource "aws_instance" "bastion" {
  ami           = var.ami
  instance_type = var.instance_type
  subnet_id     = aws_subnet.public.id
  security_groups = [aws_security_group.ec2_sg.id]
  associate_public_ip_address = true

  tags = {
    Name = "Bastion-EC2"
  }
}

# Private EC2 Instance in Private Subnet
resource "aws_instance" "private_ec2" {
  ami           = var.ami
  instance_type = var.instance_type
  subnet_id     = aws_subnet.private.id
  security_groups = [aws_security_group.ec2_sg.id]

  tags = {
    Name = "Private-EC2"
  }
}

# IAM Role for EC2 Instances to Access S3
resource "aws_iam_role" "ec2_role" {
  name = "newprofsi98600"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action    = "sts:AssumeRole"
      Effect    = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
    }]
  })
}

resource "aws_iam_role_policy_attachment" "ec2_s3_access" {
  role       = aws_iam_role.ec2_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}

resource "aws_iam_instance_profile" "ec2_profile" {
  name = "ec2_profilefsi0012"
  role = aws_iam_role.ec2_role.name
}

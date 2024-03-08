# Creates a subnet for OpenVPN-AS in the first availability zone
resource "aws_subnet" "prod_openvpn_subnet1" {
  vpc_id = var.vpc_id
  cidr_block = var.subnet1_cidr
  availability_zone = var.az1
  tags = {
    Purpose = "OpenVPN-AS HA"
    Client = "REMOVED FOR SECURITY"
    Name = "REMOVED FOR SECURITY"
  }
}

# Creates a subnet for OpenVPN-AS in the second availability zone
resource "aws_subnet" "prod_openvpn_subnet2" {
  vpc_id = var.vpc_id
  cidr_block = var.subnet2_cidr
  availability_zone = var.az2
  tags = {
    Purpose = var.service_descriptor
    Client = "REMOVED FOR SECURITY"
    Name = "REMOVED FOR SECURITY"
  }
}

# Creates an S3 bucket for storing Terraform backend
resource "aws_db_subnet_group" "database" {
  name        = "${var.rds_instance_name}-subnet-group"
  description = "Terraform created RDS subnet group"
  subnet_ids  = ["${aws_subnet.prod_openvpn_subnet1.id}","${aws_subnet.prod_openvpn_subnet2.id}"]
}

# Uploads the Ansible playbook to the S3 bucket
resource "aws_s3_bucket" "terraform-artifacts" {
  bucket = "terraform-devops-buildartifacts"
  tags = {
    Name        = "terraform-devops-buildartifacts"
    Environment = "Production"
    Client = "REMOVED FOR SECURITY"
  }
}
resource "aws_s3_object" "ansibleplaybook" {
  bucket = aws_s3_bucket.terraform-artifacts.id
  key    = "Ansible/server.yml"
  source = "../Ansible/server.yml"
  etag   = filemd5("../Ansible/server.yml")
}

# Launches an EC2 instance for OpenVPN-AS in the first subnet
resource "aws_instance" "openvpn-as-app1" {
  ami = var.ami_id
  instance_type = var.instance_type
  subnet_id = aws_subnet.prod_openvpn_subnet1.id
  vpc_security_group_ids = [aws_security_group.application.id]
  iam_instance_profile = aws_iam_instance_profile.openvpn-as-ec2profile.id
  user_data = var.user_data
  tags = {
    Purpose = var.service_descriptor
    Client = "REMOVED FOR SECURITY"
    Name = "openvpn-as-app1"
  }
}

# Launches an EC2 instance for OpenVPN-AS in the second subnet
resource "aws_instance" "openvpn-as-app2" {
  ami = var.ami_id
  instance_type = var.instance_type
  subnet_id = aws_subnet.prod_openvpn_subnet2.id
  vpc_security_group_ids = [aws_security_group.application.id]
  iam_instance_profile = aws_iam_instance_profile.openvpn-as-ec2profile.id
  user_data = var.user_data
  tags = {
    Purpose = var.service_descriptor
    Client = "REMOVED FOR SECURITY"
    Name = "REMOVED FOR SECURITY"
  }
}

# Creates Elastic IP addresses for the EC2 instances
resource "aws_eip" "elasticip1" {
  domain = "REMOVED FOR SECURITY"
}
resource "aws_eip" "elasticip2" {
  domain = "REMOVED FOR SECURITY"
}

# Assigns Elastic IPs to the EC2 instances
resource "aws_eip_association" "openvpn-as-app-eip1" {
  instance_id   = aws_instance.openvpn-as-app1.id
  allocation_id = aws_eip.elasticip1.id
}
resource "aws_eip_association" "openvpn-as-app-eip2" {
  instance_id   = aws_instance.openvpn-as-app2.id
  allocation_id = aws_eip.elasticip2.id
}

#Creates the RDS Instance
resource "aws_db_instance" "openvpn-as-rds" {
  engine = "mysql"
  engine_version = "8.0.33"
  instance_class = "db.t3.small"
  allocated_storage = 20
  identifier = var.rds_instance_name
  db_name = var.rds_db_name
  username = var.db_username
  password = var.db_password
  skip_final_snapshot = true
  backup_window = "03:00-06:00"
  maintenance_window = "Mon:00:00-Mon:03:00"
  backup_retention_period = 14
  vpc_security_group_ids = [aws_security_group.database.id]
  db_subnet_group_name = "${aws_db_subnet_group.database.id}"
  multi_az = true
  parameter_group_name = "default.mysql8.0"
  storage_encrypted = true
  tags = {
    Purpose = var.service_descriptor
    Client = "REMOVED FOR SECURITY"
    Name = "openvpn-as-rds"
  }
}

#Creates the network security group and ingress rules
resource "aws_security_group" "application" {
  name        = "openvpn-as-app-service-sg"
  vpc_id      = var.vpc_id
  description = "REMOVED FOR SECURITY"
 
  ingress {
    from_port   = REMOVED FOR SECURITY
    to_port     = REMOVED FOR SECURITY
    protocol    = "tcp"
    cidr_blocks = ["REMOVED FOR SECURITY"]
    description = "REMOVED FOR SECURITY"
  }

  ingress {
    from_port   = REMOVED FOR SECURITY
    to_port     = REMOVED FOR SECURITY
    protocol    = "REMOVED FOR SECURITY"
    cidr_blocks = ["REMOVED FOR SECURITY"]
    description = "REMOVED FOR SECURITY"
  }

  ingress {
    from_port   = REMOVED FOR SECURITY
    to_port     = REMOVED FOR SECURITY
    protocol    = "REMOVED FOR SECURITY"
    cidr_blocks = ["REMOVED FOR SECURITY"]
    description = "REMOVED FOR SECURITY"
  }
 
  ingress {
    from_port   = REMOVED FOR SECURITY
    to_port     = REMOVED FOR SECURITY
    protocol    = "REMOVED FOR SECURITY"
    cidr_blocks = ["REMOVED FOR SECURITY"]
    description = "REMOVED FOR SECURITY"
  }
  ingress {
    from_port   = REMOVED FOR SECURITY
    to_port     = REMOVED FOR SECURITY
    protocol    = "REMOVED FOR SECURITY"
    cidr_blocks = ["REMOVED FOR SECURITY"]
    description = "REMOVED FOR SECURITY"
  }

  egress {
    from_port   = REMOVED FOR SECURITY
    to_port     = REMOVED FOR SECURITY
    protocol    = "REMOVED FOR SECURITY"
    cidr_blocks = ["REMOVED FOR SECURITY"]
  }
    tags = {
    Service = "REMOVED FOR SECURITY"
  }
  lifecycle {
    create_before_destroy = true
  }
} 

#Creates the network security group and ingress rules for the RDS Instance DB
resource "aws_security_group" "database" {

  name        = "REMOVED FOR SECURITY"
  vpc_id      = var.vpc_id
  description = "SecurityGroup for OpenVPN-AS service"
 
  ingress {
    from_port   = REMOVED FOR SECURITY
    to_port     = REMOVED FOR SECURITY
    protocol    = "REMOVED FOR SECURITY"
    cidr_blocks = ["REMOVED FOR SECURITY"]
    description = "REMOVED FOR SECURITY"
  }

  egress {
    from_port   = REMOVED FOR SECURITY
    to_port     = REMOVED FOR SECURITY
    protocol    = "REMOVED FOR SECURITY"
    cidr_blocks = ["REMOVED FOR SECURITY"]
  }
    tags = {
    Purpose = var.service_descriptor
  }
  lifecycle {
    create_before_destroy = true
  }
}
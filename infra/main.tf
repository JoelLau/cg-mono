terraform {
  required_version = "~> 1.9.2"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "ap-southeast-1"
}

variable "db_user" {
  type        = string
  description = "database username for connecting to postgres rds"
}

variable "db_pass" {
  type        = string
  description = "database password for connecting to postgres rds"
}

# VPC
resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
}

# Subnet
resource "aws_subnet" "main" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "ap-southeast-1a"
}

resource "aws_subnet" "main2" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "ap-southeast-1b"
}

# Internet Gateway
resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id
}

# Route Table
resource "aws_route_table" "main" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }
}

# Route Table Association
resource "aws_route_table_association" "main" {
  subnet_id      = aws_subnet.main.id
  route_table_id = aws_route_table.main.id
}

# Security Group
resource "aws_security_group" "urlshortener-dbec2" {
  vpc_id = aws_vpc.main.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# EC2 Instance
resource "aws_instance" "rails" {
  ami                    = "ami-0e97ea97a2f374e3d"
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.main.id
  vpc_security_group_ids = [aws_security_group.urlshortener-dbec2.id]

  tags = {
    Name = "urlshortener-be"
  }
}

# RDS Instance
resource "aws_db_instance" "default" {
  allocated_storage    = 20
  engine               = "postgres"
  engine_version       = "16"
  instance_class       = "db.t3.micro"
  db_name              = "urlshortener_prod"
  username             = var.db_user
  password             = var.db_pass
  parameter_group_name = aws_db_parameter_group.custom-postgres16.name
  skip_final_snapshot  = true
  apply_immediately    = true
  db_subnet_group_name = aws_db_subnet_group.main.name

  vpc_security_group_ids = [aws_security_group.urlshortener-dbec2.id]

  tags = {
    Name = "UrlShortener DB"
  }
}

resource "aws_db_subnet_group" "main" {
  subnet_ids = [aws_subnet.main.id, aws_subnet.main2.id]
}

resource "aws_db_parameter_group" "custom-postgres16" {
  name   = "urlshortener-pgdb"
  family = "postgres16"

  lifecycle {
    create_before_destroy = true
  }
}

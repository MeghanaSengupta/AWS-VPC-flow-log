provider "aws" {
  region = "eu-west-2"
}

# Creating VPC,name, CIDR and Tags
resource "aws_vpc" "vpc_flow_logs" {
  cidr_block           = "10.0.0.0/16"
  instance_tenancy     = "default"
  enable_dns_support   = "true"
  enable_dns_hostnames = "true"
  tags = {
    Name = "vpc_flow_logs"
  }
}

# Creating Public Subnets in VPC
resource "aws_subnet" "vpc_flow_logs-public-1" {
  vpc_id                  = aws_vpc.vpc_flow_logs.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = "eu-west-2a"

  tags = {
    Name = "vpc_flow_logs-public-1"
  }
}

resource "aws_subnet" "vpc_flow_logs-public-2" {
  vpc_id                  = aws_vpc.vpc_flow_logs.id
  cidr_block              = "10.0.2.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = "eu-west-2b"

  tags = {
    Name = "vpc_flow_logs-public-2"
  }
}

# Creating Internet Gateway in AWS VPC
resource "aws_internet_gateway" "vpc_flow_logs-igw" {
  vpc_id = aws_vpc.vpc_flow_logs.id
  tags = {
    Name = "vpc_flow_logs_igw"
  }
}

# Creating Route Tables for Internet gateway
resource "aws_route_table" "vpc_flow_logs-public" {
  vpc_id = aws_vpc.vpc_flow_logs.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.vpc_flow_logs-igw.id
  }

  tags = {
    Name = "vpc_flow_logs-public-1"
  }
}

# Creating Route Associations public subnets
resource "aws_route_table_association" "vpc_flow_logs-public-1-a" {
  subnet_id      = aws_subnet.vpc_flow_logs-public-1.id
  route_table_id = aws_route_table.vpc_flow_logs-public.id
}

resource "aws_route_table_association" "vpc_flow_logs-public-2-a" {
  subnet_id      = aws_subnet.vpc_flow_logs-public-2.id
  route_table_id = aws_route_table.vpc_flow_logs-public.id
}

# Creating EC2 instances in public subnets
resource "aws_instance" "public_inst_1" {
  ami           = "ami-078a289ddf4b09ae0"
  instance_type = "t2.micro"
  subnet_id = aws_subnet.vpc_flow_logs-public-1.id
  key_name = "myKey"
  tags = {
    Name = "public_inst_1"
  }
}

resource "aws_instance" "public_inst_2" {
  ami           = "ami-078a289ddf4b09ae0"
  instance_type = "t2.micro"
  subnet_id = aws_subnet.vpc_flow_logs-public-2.id
  key_name = "myKey"
  tags = {
    Name = "public_inst_2"
  }
}

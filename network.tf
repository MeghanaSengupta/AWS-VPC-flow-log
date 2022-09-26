resource "aws_internet_gateway" "vpc_flow_logs-igw-" {
  vpc_id = aws_vpc.vpc_flow_logs.id
  }
resource "aws_route_table" "vpc_flow_logs-public-crt" {
  vpc_id = aws_vpc.vpc_flow_logs.id

  route {
    //associated subnet can reach everywhere
    cidr_block = "0.0.0.0/0"         
    gateway_id = aws_internet_gateway.vpc_flow_logs-igw-.id
  }
 }

resource "aws_route_table_association" "vpc_flow_logs-crta-public-subnet-1"{
  subnet_id = aws_subnet.vpc_flow_logs-public-1.id
  route_table_id = aws_route_table.vpc_flow_logs-public.id
}
resource "aws_security_group" "ssh-allowed" {
  vpc_id = aws_vpc.vpc_flow_logs.id

  egress {
    from_port = 0
    to_port = 0
    protocol = -1
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"       
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  }

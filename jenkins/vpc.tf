resource "aws_vpc" "hilltop-vpc" {
  cidr_block = var.vpc_cidr_block
  tags = {
    Name = "${var.env_prefix}-vpc"
  }
}

resource "aws_subnet" "hilltop-subnet-1" {
  vpc_id            = aws_vpc.hilltop-vpc.id
  cidr_block        = var.subnet_cidr_block
  availability_zone = var.avail_zone
  tags = {
    Name = "${var.env_prefix}-subnet-1"
  }
}

resource "aws_internet_gateway" "hilltop-igw" {
  vpc_id = aws_vpc.hilltop-vpc.id
  tags = {
    Name = "${var.env_prefix}-igw"
  }
}

resource "aws_default_route_table" "main-rtb" {
  default_route_table_id = aws_vpc.hilltop-vpc.default_route_table_id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.hilltop-igw.id
  }
  tags = {
    Name = "${var.env_prefix}-main-rtb"
  }
}

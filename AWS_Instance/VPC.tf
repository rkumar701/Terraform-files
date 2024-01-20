resource "aws_vpc" "vpc" {
  cidr_block = var.VPC-CIDR
  tags = {
    Name = "terraform-vpc"
  }

}
resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.VPC-subnet-pub-CIDR
  map_public_ip_on_launch = "true"
  availability_zone       = var.AZone-a
  tags = {
    Name = "tarraform-public-sub"
  }

}

resource "aws_subnet" "private_subnet" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.VPC-subnet-pvt-CIDR
  map_public_ip_on_launch = "false"
  availability_zone       = var.AZone-a
  tags = {
    Name = "tarraform-private-sub"
  }

}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "terraform-igw"
  }
}

resource "aws_nat_gateway" "ngw" {
  connectivity_type = "private"
  subnet_id         = aws_subnet.private_subnet.id
  tags = {
    Name = "terraform-ngw"
  }
}

resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id

  }
  tags = {
    Name = "terraform-public-route-table"
  }
}

resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.ngw.id

  }
  tags = {
    Name = "terraform-private-route-table"
  }
}

resource "aws_route_table_association" "public_subnet_association" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_route_table_association" "private_subnet_association" {
  subnet_id      = aws_subnet.private_subnet.id
  route_table_id = aws_route_table.private_route_table.id
}
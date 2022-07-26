# create VPC
resource "aws_vpc" "vpc" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = "${var.vpc_name}"
  }
}

# create subnet
resource "aws_subnet" "public_subnet" {
  count = length(var.public_subnet_cidr)

  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = element(var.public_subnet_cidr, count.index)
  availability_zone       = element(var.az, count.index)
  map_public_ip_on_launch = true
  tags = {
    Name = "${var.vpc_name}-subent-public${count.index + 1}"
  }
}

resource "aws_subnet" "private_subnet" {
  count = length(var.private_subnet_cidr)

  vpc_id            = aws_vpc.vpc.id
  cidr_block        = element(var.private_subnet_cidr, count.index)
  availability_zone = element(var.az, count.index)
  tags = {
    Name = "${var.vpc_name}-subent-private${count.index + 1}"
  }
}

# create IGW
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "${var.vpc_name}-igw"
  }
}

# create route table
resource "aws_route_table" "vpc_public_route" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    "Name" = "${var.vpc_name}-public-route"
  }
}

# create route table association
# Subnet 과 Route table 을 연결
resource "aws_route_table_association" "vpc_public_routing" {
  count = length(var.public_subnet_cidr)

  subnet_id      = element(aws_subnet.public_subnet.*.id, count.index)
  route_table_id = aws_route_table.vpc_public_route.id
}


# create eip for nat
resource "aws_eip" "nat_eip" {
  vpc = true
  # depends_on = [aws_internet_gateway.igw]
}

# create nat gateway
resource "aws_nat_gateway" "nat_gw" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.public_subnet[0].id
  # depends_on = [aws_internet_gateway.igw]

  tags = {
    Name = "${var.vpc_name}-nat"
  }
}

resource "aws_route_table" "private_route" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat_gw.id
 }
  tags = {
    Name = "${var.vpc_name}-private-route"
  }
}

resource "aws_route_table_association" "vpc_private_routing" {
  count = length(var.private_subnet_cidr)

  subnet_id      = element(aws_subnet.private_subnet.*.id, count.index)
  route_table_id = aws_route_table.private_route.id
}

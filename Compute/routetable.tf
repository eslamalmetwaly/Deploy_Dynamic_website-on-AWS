# Route Table
resource "aws_route_table" "bt_public_rt" {
  vpc_id = aws_vpc.BTVPC.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.bt_igw.id
  }

  tags = {
    Name = "BTVPC-public-rt"
  }
}
# Route Table Association for Subnet 1
resource "aws_route_table_association" "bt_subnet_1_association" {
  subnet_id      = aws_subnet.bt_public_subnet_1.id
  route_table_id = aws_route_table.bt_public_rt.id
}

# Route Table Association for Subnet 2
resource "aws_route_table_association" "bt_subnet_2_association" {
  subnet_id      = aws_subnet.bt_public_subnet_2.id
  route_table_id = aws_route_table.bt_public_rt.id
}

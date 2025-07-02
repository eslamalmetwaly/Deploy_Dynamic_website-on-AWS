resource "aws_vpc" "BTVPC" {
  cidr_block = "10.0.0.0/16"
  enable_dns_support = true
  enable_dns_hostnames = true  # تمكين DNS settings

  tags = {
    Name = "BTVPC"
  }
}
# Internet GateWay
resource "aws_internet_gateway" "bt_igw" {
  vpc_id = aws_vpc.BTVPC.id

  tags = {
    Name = "BTVPC-igw"
  }
}

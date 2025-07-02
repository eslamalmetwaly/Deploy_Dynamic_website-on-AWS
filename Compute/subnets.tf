# Public Subnet 1
resource "aws_subnet" "bt_public_subnet_1" {
  vpc_id            = aws_vpc.BTVPC.id
  cidr_block        = "10.0.10.0/24"
  availability_zone = "us-east-1a"
  map_public_ip_on_launch = true
  enable_resource_name_dns_a_record_on_launch    = true  # Enable DNS A record for resource name
  enable_resource_name_dns_aaaa_record_on_launch = false  # Enable DNS AAAA record for resource name


  tags = {
    Name = "BTVPC-public-subnet-1"
  }
}

# Public Subnet 2
resource "aws_subnet" "bt_public_subnet_2" {
  vpc_id            = aws_vpc.BTVPC.id
  cidr_block        = "10.0.20.0/24"
  availability_zone = "us-east-1b"
  map_public_ip_on_launch = true
  enable_resource_name_dns_a_record_on_launch    = true  # Enable DNS A record for resource name
  enable_resource_name_dns_aaaa_record_on_launch = false  # Enable DNS AAAA record for resource name


  tags = {
    Name = "BTVPC-public-subnet-2"
  }
}

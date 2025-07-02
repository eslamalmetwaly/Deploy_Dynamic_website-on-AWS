resource "aws_instance" "bt_ec2_instance" {
  ami             = "ami-0f88e80871fd81e91"   # Amazon Linux 2023 AMI for us-east-1
  instance_type   = "t2.micro"
  subnet_id       = aws_subnet.bt_public_subnet_1.id
  key_name        = "bankbt"        
  security_groups = [aws_security_group.bt_web_sg.id]  
  associate_public_ip_address = true

  tags = {
    Name = "BTBank"
  }
}

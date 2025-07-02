resource "aws_security_group" "bt_alb_sg" {
  name        = "bt-alb-sg"
  description = "Allow HTTP inbound and all outbound"
  vpc_id      = aws_vpc.BTVPC.id

  ingress {
    description = "Allow HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "bt-alb-sg"
  }
}

# alb.tf
resource "aws_lb" "bt_alb" {
  name               = "bt-app-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.bt_alb_sg.id]
  subnets            = [
     aws_subnet.bt_public_subnet_1.id,
          aws_subnet.bt_public_subnet_2.id

  ]
  tags = {
    Name = "BTALB"
  }
}

resource "aws_lb_listener" "bt_alb_listener" {
  load_balancer_arn = aws_lb.bt_alb.arn
  port              = 80
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.bt_target_group.arn
  }
}

resource "aws_lb_target_group" "bt_target_group" {
  name     = "bt-target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.BTVPC.id
  health_check {
    path                = "/"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }
  tags = {
    Name = "bt-target"
  }
}

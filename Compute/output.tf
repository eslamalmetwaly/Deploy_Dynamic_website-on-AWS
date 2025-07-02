# Outputs
output "instance_id" {
  value = aws_instance.bt_ec2_instance.id
}

output "vpc_id" {
  value = aws_vpc.BTVPC.id
}

output "subnet_1_id" {
  value = aws_subnet.bt_public_subnet_1.id
}

output "subnet_2_id" {
  value = aws_subnet.bt_public_subnet_2.id
}

output "security_group_id" {
  value = aws_security_group.bt_web_sg.id
}
output "alb_arn" {
  value = aws_lb.bt_alb.arn
}

output "alb_dns_name" {
  value = aws_lb.bt_alb.dns_name
}

output "alb_listener_arn" {
  value = aws_lb_listener.bt_alb_listener.arn
}

output "target_group_arn" {
  value = aws_lb_target_group.bt_target_group.arn
}

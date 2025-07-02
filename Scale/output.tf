output "ami_id" {
  value = aws_ami_from_instance.bt_ec2_ami.id
}


output "launch_template_id" {
  value = aws_launch_template.bt_launch_template.id
}

output "auto_scaling_group_id" {
  value = aws_autoscaling_group.bt_asg.id
}


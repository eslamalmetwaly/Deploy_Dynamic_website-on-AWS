resource "aws_launch_template" "bt_launch_template" {
  name          = "bt-launch-template"
  image_id      = aws_ami_from_instance.bt_ec2_ami.id
  instance_type = "t2.micro"
  key_name      = "bankbt"
   vpc_security_group_ids = [
    data.terraform_remote_state.infra.outputs.security_group_id
  ]
  user_data = base64encode(<<-EOF
              #!/bin/bash
              cd /var/www/
              npm run dev
EOF
  )
  lifecycle {
    create_before_destroy = true
  }
}
resource "aws_autoscaling_group" "bt_asg" {
  desired_capacity     = 2
  max_size             = 3
  min_size             = 1
  launch_template {
    id      = aws_launch_template.bt_launch_template.id
    version = "$Latest"
  }
  vpc_zone_identifier  = [
   data.terraform_remote_state.infra.outputs.subnet_1_id,
   data.terraform_remote_state.infra.outputs.subnet_2_id
  ]
  target_group_arns    = [data.terraform_remote_state.infra.outputs.target_group_arn]
  health_check_type    = "EC2"
  health_check_grace_period = 300
  wait_for_capacity_timeout = "0"

  tag {
    key                 = "bt-autoscale-instance"
    value               = "bt-autoscale-instance"
    propagate_at_launch = true
  }
}

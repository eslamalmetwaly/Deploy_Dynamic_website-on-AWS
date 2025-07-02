# AMI from EC2 
resource "aws_ami_from_instance" "bt_ec2_ami" {
  name               = "bt_ami_${formatdate("YYYY-MM-DD-HH-mm-ss", timestamp())}"
  source_instance_id = data.terraform_remote_state.infra.outputs.instance_id
  description        = "AMI for BT EC2 instance"
  depends_on         = []

  tags = {
    Name = "bt_ami"
  }
}

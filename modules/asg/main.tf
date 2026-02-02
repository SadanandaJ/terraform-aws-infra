resource "aws_launch_template" "this" {
  image_id      = data.aws_ami.amazon_linux.id
  instance_type = var.instance_type
  key_name      = var.key_name

  user_data = base64encode(var.user_data)
}

resource "aws_autoscaling_group" "this" {
  min_size         = var.min
  max_size         = var.max
  desired_capacity = var.desired

  vpc_zone_identifier = var.private_subnets
  target_group_arns  = [var.target_group_arn]

  launch_template {
    id      = aws_launch_template.this.id
    version = "$Latest"
  }
}


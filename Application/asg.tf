data "aws_ami" "cint" {
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn2-ami-kernel-*"]
  }

  owners = ["amazon"]
}

resource "aws_launch_configuration" "cint_app" {
  name_prefix     = "Cint-App"
  image_id        = data.aws_ami.cint.id
  instance_type   = var.instance_type
  user_data       = file("user-data.sh")
  security_groups = [aws_security_group.cint_app.id]

  lifecycle {
    create_before_destroy = true
  }
  root_block_device {
    volume_type           = var.volume_type
    volume_size           = var.volume_size
    delete_on_termination = true
    encrypted             = false
  }
}

resource "aws_placement_group" "cint_app" {
  name     = "Cint-App-Group"
  strategy = "spread"
  tags     = var.all_tags
}

resource "aws_autoscaling_group" "cint_app" {
  name                      = "cint-app-asg"
  min_size                  = var.cint_app_count_min
  max_size                  = var.cint_app_count_max
  desired_capacity          = var.cint_app_count_des
  health_check_type         = "EC2"
  health_check_grace_period = 300
  placement_group           = aws_placement_group.cint_app.id
  launch_configuration      = aws_launch_configuration.cint_app.name
  vpc_zone_identifier       = data.aws_subnets.private.ids

  lifecycle {
    ignore_changes = [load_balancers, target_group_arns]
  }

  tag {
    key                 = "Name"
    value               = "Cint-App"
    propagate_at_launch = true
  }

}

##############################################
# Create Default Target Group for Listeners
##############################################

resource "aws_lb_target_group" "cint_target_group" {
  name     = var.target_group
  port     = var.app_port
  protocol = "HTTP"
  vpc_id   = data.aws_vpc.cint.id
  tags     = var.all_tags
  health_check {
    enabled             = true
    healthy_threshold   = 3
    interval            = 30
    path                = "/"
    protocol            = "HTTP"
    timeout             = 5
    unhealthy_threshold = 3
    matcher             = "200"
  }
}

resource "aws_autoscaling_attachment" "cint_app" {
  autoscaling_group_name = aws_autoscaling_group.cint_app.id
  alb_target_group_arn   = aws_lb_target_group.cint_target_group.arn
}
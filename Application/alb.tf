resource "aws_lb" "cint_alb" {
  name                       = var.alb_name
  subnets                    = data.aws_subnets.public.ids
  security_groups            = [aws_security_group.alb_sg.id]
  internal                   = false
  enable_deletion_protection = true

  tags = var.all_tags
}

resource "aws_lb_listener" "http_listener" {
  load_balancer_arn = aws_lb.cint_alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.cint_target_group.arn
  }

  tags = var.all_tags
}
resource "aws_lb" "default" {
  name            = var.aws_lb_name
  subnets         = var.aws_subnet_ids
  security_groups = var.aws_security_group_ids
}

resource "aws_lb_listener" "main" {
  load_balancer_arn = aws_lb.default.id
  port              = "80"
  protocol          = "HTTP"

  default_action {
    target_group_arn = var.targetgroup_arn
    type             = "forward"
  }
}
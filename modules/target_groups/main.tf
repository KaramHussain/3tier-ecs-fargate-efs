resource "aws_lb_target_group" "main" {
  name        = "example-target-group"
  port        = var.target_group_port
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = "ip"
}


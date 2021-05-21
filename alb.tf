resource "aws_lb" "wego" {
  name               = "alb-${var.environments}"
  subnets            = data.aws_subnet_ids.default.ids
  load_balancer_type = "application"
  security_groups    = [aws_security_group.lb.id]

}

resource "aws_lb_listener" "https_forward" {
  load_balancer_arn = aws_lb.wego.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.wego.arn
  }
}

resource "aws_lb_target_group" "wego" {
  name        = "${var.environments}-api"
  port        = 8080
  protocol    = "HTTP"
  vpc_id      = data.aws_vpc.default.id
  target_type = "ip"

  health_check {
    healthy_threshold   = "2"
    interval            = "10"
    protocol            = "HTTP"
    matcher             = "200-299"
    timeout             = "5"
    path                = "/"
    unhealthy_threshold = "2"
  }
}
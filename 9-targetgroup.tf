resource "aws_lb_target_group" "webtier" {
  name        = "webtier-grp"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = aws_vpc.main.id
  target_type = "instance"

  health_check {
    enabled             = true
    interval            = 30
    path                = "/"
    protocol            = "HTTP"
    healthy_threshold   = 5
    unhealthy_threshold = 2
    timeout             = 5
    matcher             = "200"
  }

  tags = {
    Name    = "vanessaTargetGroup"
    Service = "vanessa"
    Owner   = "User"
    Project = "Web Service"
  }
}
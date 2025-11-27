resource "aws_lb" "web_tier" {
  name               = "web-lbl"
  internal           = false
  load_balancer_type = "application"

  security_groups = [aws_security_group.weblb.id]
  subnets = [
    aws_subnet.public-us-east-1a.id,
    aws_subnet.public-us-east_1b.id,
    aws_subnet.public-us-east_1c.id

  ]
  enable_deletion_protection = false
  #Lots of death and suffering here, make sure it's false

  tags = {
    Name    = "vanessaLoadBalancer"
    Service = "vanessa"
    Owner   = "User"
    Project = "Web Service"
  }
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.web_tier.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.webtier.arn

  }
}


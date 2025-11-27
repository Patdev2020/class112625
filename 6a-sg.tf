
# for web server only 
resource "aws_security_group" "weblb" {
  name        = "weblb"
  description = "Allow HTTP and SSH for web server"
  vpc_id      = aws_vpc.main.id

  tags = {
    Name = "Allow HTTP and SSH for web serve"
  }
}

resource "aws_vpc_security_group_ingress_rule" "httplb" {
  security_group_id = aws_security_group.weblb.id

  cidr_ipv4 = "0.0.0.0/0"
  # referenced_security_group_id = ""
  from_port   = 80
  ip_protocol = "tcp"
  to_port     = 80

  tags = {
    Name = "HTTP"
  }
}


resource "aws_vpc_security_group_egress_rule" "egresslb" {
  security_group_id = aws_security_group.weblb.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}

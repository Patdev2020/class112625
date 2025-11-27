resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name    = "vanessa-igw"
    Service = "application"
    Owner   = " Paul"
    Planet  = "Mars"
  }
}
resource "aws_eip" "vanessa-nat" {
  domain = "vpc"

  tags = {
    Name = "terraform-eip-for-nat"
  }

  depends_on = [aws_internet_gateway.igw] # explict dependency 
}

resource "aws_nat_gateway" "main" {
  allocation_id = aws_eip.vanessa-nat.id # implict dependency for eip
  subnet_id     = aws_subnet.public-us-east-1a.id

  tags = {
    Name = "terraform-nat-gw"
  }

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.igw]
}
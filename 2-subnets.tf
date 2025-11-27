########################## Public subnets ##########################


resource "aws_subnet" "public-us-east-1a" {
  vpc_id = aws_vpc.main.id
  # step 1: make VPC
  # step 2: get VPC ID
  # step 3: add VPC ID into vpc_id argument in this subnet 
  # which VPC to create subnet in

  cidr_block              = "10.44.1.0/24"
  availability_zone       = "us-east-1a" # specify AZ 
  map_public_ip_on_launch = true         # allow public IPs to be assigned 

  tags = {
    Name    = "public-subnet-us-east-1a"
    Service = "application"
    Owner   = "Paul"
    Planet  = "Mars"
  }
}


resource "aws_subnet" "public-us-east_1b" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.44.2.0/24"
  availability_zone       = "us-east-1b" # specify AZ 
  map_public_ip_on_launch = true         # allow public IPs to be assigned 

  tags = {
    Name    = "public-subnet-us-east-1b"
    Service = "application"
    Owner   = "Paul"
    Planet  = "Mars"
  }
}


resource "aws_subnet" "public-us-east_1c" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.44.3.0/24"
  availability_zone       = "us-east-1c" # specify AZ 
  map_public_ip_on_launch = true         # allow public IPs to be assigned 

  tags = {
    Name    = "public-subnet-us-east-1c"
    Service = "application"
    Owner   = "Paul"
    Planet  = "Mars"
  }
}

########################## Private subnets ##########################

resource "aws_subnet" "private-us-east-1a" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.44.10.0/24"
  availability_zone       = "us-east-1a" # specify AZ 
  map_public_ip_on_launch = false

  tags = {
    Name    = "private-subnet-us-east-1a"
    Service = "application"
    Owner   = "Paul"
    Planet  = "Mars"
  }
}


resource "aws_subnet" "private-us-east-1b" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.44.20.0/24"
  availability_zone       = "us-east-1b" # specify AZ 
  map_public_ip_on_launch = false

  tags = {
    Name    = "private-subnet-us-east-1b"
    Service = "application"
    Owner   = "Paul"
    Planet  = "Mars"
  }
}


resource "aws_subnet" "private-us-east-1c" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.44.30.0/24"
  availability_zone       = "us-east-1c" # specify AZ 
  map_public_ip_on_launch = false

  tags = {
    Name    = "private-subnet-us-east-1c"
    Service = "application"
    Owner   = "Paul"
    Planet  = "Mars"
  }
}

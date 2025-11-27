resource "aws_instance" "web_server" {
  ami                         = "ami-xxxxxxxxxxxxxx"
  associate_public_ip_address = true
  instance_type               = "t3.micro"

  # key_name = 
  vpc_security_group_ids = [aws_security_group.ping.id, aws_security_group.web_server.id]
  subnet_id              = aws_subnet.public-us-east-1a.id

  user_data = file("user_data.sh")
  # user_data = file("panama.sh")

  tags = {
    Name = "web-server-vanessa"
  }
}
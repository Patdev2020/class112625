resource "aws_launch_template" "web_tier" {
  name_prefix   = "web-lt"
  description   = "Launch template"
  image_id      = "ami-xxxxxxxxxx"
  instance_type = "t3.micro"

  vpc_security_group_ids = [aws_security_group.weblb.id]

  user_data = base64encode(file("user_data.sh"))

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name    = "vanessa-lt"
      Service = "application1"
      Owner   = "Chewbacca"
      Planet  = "Mars"
    }
  }

  lifecycle {
    create_before_destroy = true
  }
}
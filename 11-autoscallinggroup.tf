resource "aws_autoscaling_group" "webtier" {
  name_prefix             = "web-auto-scaling-grp"
  min_size                = 3
  max_size                = 9
  default_cooldown        = 60
  default_instance_warmup = 60

  # desired_capacity = 6
  vpc_zone_identifier = [
    aws_subnet.private-us-east-1a.id,
    aws_subnet.private-us-east-1b.id,
    aws_subnet.private-us-east-1c.id

  ]

  health_check_type         = "ELB"
  health_check_grace_period = 120
  force_delete              = true
  target_group_arns         = [aws_lb_target_group.webtier.arn]


  launch_template {
    id = aws_launch_template.web_tier.id


    version = "$Latest"
  }

  enabled_metrics = ["GroupMinSize", "GroupMaxSize", "GroupDesiredCapacity", "GroupInServiceInstances", "GroupTotalInstances"]

  # Instance protection for launching
  initial_lifecycle_hook {
    name                  = "instance-protection-launch"
    lifecycle_transition  = "autoscaling:EC2_INSTANCE_LAUNCHING"
    default_result        = "CONTINUE"
    heartbeat_timeout     = 60
    notification_metadata = "{\"key\":\"value\"}"
  }

  # Instance protection for terminating
  initial_lifecycle_hook {
    name                 = "scale-in-protection"
    lifecycle_transition = "autoscaling:EC2_INSTANCE_TERMINATING"
    default_result       = "CONTINUE"
    heartbeat_timeout    = 300
  }

  tag {
    key                 = "Name"
    value               = "web-instance"
    propagate_at_launch = true
  }

}


resource "aws_autoscaling_policy" "web_cpu_policy" {
  depends_on                = [aws_autoscaling_group.webtier]
  name                      = "web_cpu_policy"
  autoscaling_group_name    = aws_autoscaling_group.webtier.name
  policy_type               = "TargetTrackingScaling"
  estimated_instance_warmup = 60

  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }
    target_value = 60
  }
}
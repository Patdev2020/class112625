resource "aws_autoscaling_policy" "webpoly" {
  name                   = "web_cpu_scaler"
  autoscaling_group_name = aws_autoscaling_group.webtier.name
  policy_type            = "TargetTrackingScaling"

  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }
    target_value = 40.0
  }

}
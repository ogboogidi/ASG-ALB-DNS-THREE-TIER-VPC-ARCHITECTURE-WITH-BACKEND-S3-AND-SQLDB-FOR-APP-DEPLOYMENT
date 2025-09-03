# create a launch template for auto scaling group

resource "aws_launch_template" "luxe_server_lt" {
  name = "luxe-server-lt"
  key_name = var.key_name
  image_id = var.ami_id
  instance_type = var.instance_type
  user_data = base64encode(file("scripts/luxe_app.sh"))

  network_interfaces {
    associate_public_ip_address = true
    security_groups = [var.asg_sg_id]
  }

  tags = merge(var.tags,
    {
    Name = "${var.tags.project}-${var.tags.application}-${var.tags.environment}-server_lt"
    }
    )

}

#create auto scaling group

resource "aws_autoscaling_group" "luxe_asg" {
  name = "luxe-asg"
  desired_capacity = 3
  max_size = 6
  min_size = 2
  health_check_grace_period = 300
  health_check_type = "ELB"
  vpc_zone_identifier = var.public_subnets[*]
  target_group_arns = [var.target_group_arn]

  launch_template {
    id = aws_launch_template.luxe_server_lt.id
    version = "$Latest"
  }
}


resource "aws_autoscaling_policy" "cpu_target_tracking" {
  name = "cpu-target-tracking"
  policy_type = "TargetTrackingScaling"
  autoscaling_group_name = aws_autoscaling_group.luxe_asg.name

  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }
    target_value = 75.0
    disable_scale_in = false
  }
}
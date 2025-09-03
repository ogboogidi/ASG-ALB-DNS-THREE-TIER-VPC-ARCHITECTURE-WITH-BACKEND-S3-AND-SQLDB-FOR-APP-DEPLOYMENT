#create application load balancer

resource "aws_lb" "luxe_alb" {
    internal = false
    name = "luxe-alb"
    load_balancer_type = "application"
    subnets = var.public_subnets[*]
    security_groups = [var.alb_sg_id]

    tags = merge(var.tags,
    {
    Name = "${var.tags.project}-${var.tags.application}-${var.tags.environment}-alb"
    }
    )
}

#create target groups for alb

resource "aws_lb_target_group" "luxe_tg" {
  name = "luxe-tg"
  target_type = "instance"
  vpc_id = var.vpc_id
  port = "80"
  protocol = "HTTP"


  tags = merge(var.tags,
    {
    Name = "${var.tags.project}-${var.tags.application}-${var.tags.environment}-tg"
    }
    )
}


#create listeners for ALB
resource "aws_lb_listener" "luxe_listener" {
  load_balancer_arn = aws_lb.luxe_alb.arn
  port = "80"
  protocol = "HTTP"

  
  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.luxe_tg.arn
  }
}
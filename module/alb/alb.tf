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
resource "aws_lb_listener" "luxe_listener_HTTP" {
  load_balancer_arn = aws_lb.luxe_alb.arn
  port = "80"
  protocol = "HTTP"

  
  default_action {
    type = "redirect"
    redirect {
      port = "443"
      protocol = "HTTPS"
      status_code = "HTTP_301" 
    }
  }
}

resource "aws_lb_listener" "luxe_listener_HTTPS" {
  load_balancer_arn = aws_lb.luxe_alb.arn
  port = "443"
  protocol = "HTTPS"
  ssl_policy = "ELBSecurityPolicy-2016-08"
  certificate_arn = data.aws_acm_certificate.ssl_certificate.arn


  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.luxe_tg.arn
  }


}

data "aws_acm_certificate" "ssl_certificate" {
  domain = "momentstravel.org"
  most_recent = true
  statuses = ["ISSUED"]
  
}
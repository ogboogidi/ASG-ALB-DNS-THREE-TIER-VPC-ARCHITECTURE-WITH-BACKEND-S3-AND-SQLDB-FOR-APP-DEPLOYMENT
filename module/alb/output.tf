output "target_group_arn" {
  value = aws_lb_target_group.luxe_tg.arn
}

output "alb_dns_name" {
  value = aws_lb.luxe_alb.dns_name
  description = "DNS name of the ALB"
}
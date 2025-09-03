# create security group for alb

resource "aws_security_group" "alb_sg" {
  vpc_id = var.vpc_id
  description = "allow HTTP inbound traffic from the internet and all outbound traffic"

  tags = merge(var.tags,
    {
    Name = "${var.tags.project}-${var.tags.application}-${var.tags.environment}-alb_sg"
    }
    )

}

resource "aws_vpc_security_group_ingress_rule" "HTTP" {
  security_group_id = aws_security_group.alb_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}


resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.alb_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}


# create security group for Auto-Scaling Group (ASG)

resource "aws_security_group" "asg_sg" {
  vpc_id = var.vpc_id
  description = "allow HTTP inbound traffic from the ALB and SSH from anywhere and all outbound traffic"

  tags = merge(var.tags,
    {
    Name = "${var.tags.project}-${var.tags.application}-${var.tags.environment}-asg_sg"
    }
    )

}

resource "aws_vpc_security_group_ingress_rule" "HTTP_from_alb" {
  security_group_id = aws_security_group.asg_sg.id
  referenced_security_group_id = aws_security_group.alb_sg.id
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}

resource "aws_vpc_security_group_ingress_rule" "SSH" {
  security_group_id = aws_security_group.asg_sg.id
  cidr_ipv4 = "0.0.0.0/0"
  to_port = "22"
  from_port = "22"
  ip_protocol = "tcp"
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4_from_asg" {
  security_group_id = aws_security_group.asg_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}
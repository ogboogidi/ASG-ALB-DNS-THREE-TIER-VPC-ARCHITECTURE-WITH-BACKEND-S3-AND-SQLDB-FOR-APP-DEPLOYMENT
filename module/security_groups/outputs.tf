output "alb_sg_id" {
  value = aws_security_group.alb_sg.id
}

output "asg_sg_id" {
  value = aws_security_group.asg_sg.id
}

output "bastion_host_sg" {
  value = aws_security_group.bastion_host_sg.id
}

output "luxe_private_servers_sg" {
  value = aws_security_group.luxe_private_servers_sg.id
}

output "luxe_db_sg" {
  value = aws_security_group.luxe_db_sg.id
}
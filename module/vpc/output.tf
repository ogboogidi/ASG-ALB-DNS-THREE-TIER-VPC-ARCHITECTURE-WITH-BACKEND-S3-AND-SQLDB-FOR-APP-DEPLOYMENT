output "vpc_id" {
  value = aws_vpc.luxe_vpc.id
}

output "public_subnets" {
  value = [
    aws_subnet.luxe_public_subnet_01_AZ1a.id, 
    aws_subnet.luxe_public_subnet_02_AZ1b.id
  ]
}


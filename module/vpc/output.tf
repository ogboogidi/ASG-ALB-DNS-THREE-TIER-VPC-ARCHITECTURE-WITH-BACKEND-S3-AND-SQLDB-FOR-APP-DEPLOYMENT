output "vpc_id" {
  value = aws_vpc.luxe_vpc.id
}

output "public_subnets" {
  value = [
    aws_subnet.luxe_public_subnet_01_AZ1a.id, 
    aws_subnet.luxe_public_subnet_02_AZ1b.id
  ]
}

output "luxe_private_subnets" {
  value = {
    1 = aws_subnet.luxe_private_subnet_03_AZ1a.id
    2 = aws_subnet.luxe_private_subnet_05_AZ1b.id
  }
}

output "luxe_db_subnets" {
  value = [
    aws_subnet.db_private_subnet_04_AZ1a.id,
    aws_subnet.db_private_subnet_06_AZ1b.id
  ]
}
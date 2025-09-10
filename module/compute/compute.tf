#create the bastion host server

resource "aws_instance" "luxe_bastion_host" {
  ami = var.ami_id
  key_name = var.key_name
  instance_type = var.instance_type
  associate_public_ip_address = true
  subnet_id = var.public_subnets[0]
  security_groups = [var.bastion_host_sg]



    tags = merge(var.tags,
    {
    Name = "${var.tags.project}-${var.tags.application}-${var.tags.environment}-bastion_host_server"
    }
    )

}


#create two private servers in AZ1a and AZ1b

resource "aws_instance" "luxe_private_servers" {
  ami = var.ami_id
  key_name = var.key_name
  instance_type = var.instance_type
  associate_public_ip_address = false

  for_each = var.luxe_private_subnets
  subnet_id = each.value
  
  security_groups = [var.luxe_private_servers_sg]



    tags = merge(var.tags,
    {
    Name = "${var.tags.project}-${var.tags.application}-${var.tags.environment}-private_servers"
    }
    )

}

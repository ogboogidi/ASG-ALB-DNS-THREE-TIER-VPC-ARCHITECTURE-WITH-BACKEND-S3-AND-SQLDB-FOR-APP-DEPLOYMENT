resource "aws_vpc" "luxe_vpc" {
  cidr_block = var.cidr_block
  instance_tenancy = "default"



tags = merge(var.tags,
    {
    Name = "${var.tags["project"]}-${var.tags["application"]}-${var.tags["environment"]}-vpc"
    }
    )
}

#configure the internet gateway

resource "aws_internet_gateway" "luxe_igw" {
  vpc_id = aws_vpc.luxe_vpc.id


  tags = merge(var.tags,
    {
    Name = "${var.tags.project}-${var.tags.application}-${var.tags.environment}-igw"
    }
    )
}

#configure two public subnets for AZ1a and AZ1b

resource "aws_subnet" "luxe_public_subnet_01_AZ1a" {
  vpc_id = aws_vpc.luxe_vpc.id
  cidr_block = var.public_subnet_cidr_block[0]
  availability_zone = var.availability_zones[0]

   tags = merge(var.tags,
    {
    Name = "${var.tags.project}-${var.tags.application}-${var.tags.environment}-public_subnet_01_AZ1a"
    }
    )

}

resource "aws_subnet" "luxe_public_subnet_02_AZ1b" {
  vpc_id = aws_vpc.luxe_vpc.id
  cidr_block = var.public_subnet_cidr_block[1]
  availability_zone = var.availability_zones[1]

   tags = merge(var.tags,
    {
    Name = "${var.tags.project}-${var.tags.application}-${var.tags.environment}-public_subnet_02_AZ1b"
    }
    )

}


#configure public route table 

resource "aws_route_table" "public_rtb" {
  vpc_id = aws_vpc.luxe_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.luxe_igw.id
  }


  tags = merge(var.tags,
    {
    Name = "${var.tags.project}-${var.tags.application}-${var.tags.environment}-public_rtb"
    }
    )

}

resource "aws_route_table_association" "a" {
  subnet_id = aws_subnet.luxe_public_subnet_01_AZ1a.id
  route_table_id = aws_route_table.public_rtb.id
}


resource "aws_route_table_association" "b" {
  subnet_id = aws_subnet.luxe_public_subnet_02_AZ1b.id
  route_table_id = aws_route_table.public_rtb.id
}



#configure one private subnet AZ1a

resource "aws_subnet" "luxe_private_subnet_03_AZ1a" {
  vpc_id = aws_vpc.luxe_vpc.id
  cidr_block = var.private_subnet_cidr_block[0]
  availability_zone = var.availability_zones[0]

   tags = merge(var.tags,
    {
    Name = "${var.tags.project}-${var.tags.application}-${var.tags.environment}-private_subnet_03_AZ1a"
    }
    )

}

#configure one database private subnet AZ1a

resource "aws_subnet" "db_private_subnet_04_AZ1a" {
  vpc_id = aws_vpc.luxe_vpc.id
  cidr_block = var.db_private_subnet_cidr_block[0]
  availability_zone = var.availability_zones[0]

   tags = merge(var.tags,
    {
    Name = "${var.tags.project}-${var.tags.application}-${var.tags.environment}-db_private_subnet_04_AZ1a"
    }
    )

}
#configurre the elastic IP for the NAT_GATEWAY for AZ1a
resource "aws_eip" "nat_eip_AZ1a" {
   domain   = "vpc"
}


#configure the NAT_GATEWAY for AZ1A
resource "aws_nat_gateway" "luxe_nat_gw_AZ1a" {
  subnet_id = aws_subnet.luxe_public_subnet_01_AZ1a.id
  allocation_id = aws_eip.nat_eip_AZ1a.id

  depends_on = [ aws_eip.nat_eip_AZ1a, aws_subnet.luxe_public_subnet_01_AZ1a ]

}

#configure the private route table
resource "aws_route_table" "private_rtb" {
  vpc_id = aws_vpc.luxe_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.luxe_nat_gw_AZ1a.id
  }


  tags = merge(var.tags,
    {
    Name = "${var.tags.project}-${var.tags.application}-${var.tags.environment}-private_rtb"
    }
    )

}

resource "aws_route_table_association" "c" {
  subnet_id = aws_subnet.luxe_private_subnet_03_AZ1a.id
  route_table_id = aws_route_table.private_rtb.id
}


resource "aws_route_table_association" "d" {
  subnet_id = aws_subnet.db_private_subnet_04_AZ1a.id
  route_table_id = aws_route_table.private_rtb.id
}




#configure one private subnet AZ1b

resource "aws_subnet" "luxe_private_subnet_05_AZ1b" {
  vpc_id = aws_vpc.luxe_vpc.id
  cidr_block = var.private_subnet_cidr_block[1]
  availability_zone = var.availability_zones[1]

   tags = merge(var.tags,
    {
    Name = "${var.tags.project}-${var.tags.application}-${var.tags.environment}-private_subnet_05_AZ1b"
    }
    )

}

#configure one database private subnet AZ1b

resource "aws_subnet" "db_private_subnet_06_AZ1b" {
  vpc_id = aws_vpc.luxe_vpc.id
  cidr_block = var.db_private_subnet_cidr_block[1]
  availability_zone = var.availability_zones[1]

   tags = merge(var.tags,
    {
    Name = "${var.tags.project}-${var.tags.application}-${var.tags.environment}-db_private_subnet_06_AZ1b"
    }
    )

}
#configurre the elastic IP for the NAT_GATEWAY for AZ1B
resource "aws_eip" "nat_eip_AZ1b" {
   domain   = "vpc"
}


#configure the NAT_GATEWAY for AZ1b
resource "aws_nat_gateway" "luxe_nat_gw_AZ1b" {
  subnet_id = aws_subnet.luxe_public_subnet_02_AZ1b.id
  allocation_id = aws_eip.nat_eip_AZ1b.id

  depends_on = [ aws_eip.nat_eip_AZ1b, aws_subnet.luxe_public_subnet_02_AZ1b ]

}

#configure the private route table for az1b
resource "aws_route_table" "private_rtb_az1b" {
  vpc_id = aws_vpc.luxe_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.luxe_nat_gw_AZ1b.id
  }


  tags = merge(var.tags,
    {
    Name = "${var.tags.project}-${var.tags.application}-${var.tags.environment}-private_rtb"
    }
    )

}

resource "aws_route_table_association" "e" {
  subnet_id = aws_subnet.luxe_private_subnet_05_AZ1b.id
  route_table_id = aws_route_table.private_rtb_az1b.id
}


resource "aws_route_table_association" "f" {
  subnet_id = aws_subnet.db_private_subnet_06_AZ1b.id
  route_table_id = aws_route_table.private_rtb_az1b.id
}
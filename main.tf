provider "aws" {
  region = "us-east-1"
}


module "vpc" {
  source     = "./module/vpc"
  tags       = local.luxe_tags
  cidr_block = var.cidr_block
  public_subnet_cidr_block = var.public_subnet_cidr_block
  private_subnet_cidr_block = var.private_subnet_cidr_block
  availability_zones = var.availability_zones
  db_private_subnet_cidr_block = var.db_private_subnet_cidr_block
}


module "security_groups" {
  source = "./module/security_groups"
  tags = local.luxe_tags
  vpc_id = module.vpc.vpc_id
}


module "alb" {
  source = "./module/alb"
  tags = local.luxe_tags
  vpc_id = module.vpc.vpc_id
  alb_sg_id = module.security_groups.alb_sg_id
  public_subnets = module.vpc.public_subnets
  luxe_asg_id = module.asg.luxe_asg_id
}


module "asg"{
  source = "./module/asg"
  tags = local.luxe_tags
  target_group_arn = module.alb.target_group_arn
  key_name = var.key_name
  ami_id = var.ami_id
  instance_type = var.instance_type
  asg_sg_id = module.security_groups.asg_sg_id
  public_subnets = module.vpc.public_subnets



}
  

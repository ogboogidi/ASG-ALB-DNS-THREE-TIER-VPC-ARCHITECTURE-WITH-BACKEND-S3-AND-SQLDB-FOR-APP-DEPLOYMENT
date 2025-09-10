provider "aws" {
  region = "us-east-1"
}


module "vpc" {
  source                       = "./module/vpc"
  tags                         = local.luxe_tags
  cidr_block                   = var.cidr_block
  public_subnet_cidr_block     = var.public_subnet_cidr_block
  private_subnet_cidr_block    = var.private_subnet_cidr_block
  availability_zones           = var.availability_zones
  db_private_subnet_cidr_block = var.db_private_subnet_cidr_block
}


module "security_groups" {
  source = "./module/security_groups"
  tags   = local.luxe_tags
  vpc_id = module.vpc.vpc_id
}


module "alb" {
  source         = "./module/alb"
  tags           = local.luxe_tags
  vpc_id         = module.vpc.vpc_id
  alb_sg_id      = module.security_groups.alb_sg_id
  public_subnets = module.vpc.public_subnets
  luxe_asg_id    = module.asg.luxe_asg_id
}


module "asg" {
  source           = "./module/asg"
  tags             = local.luxe_tags
  target_group_arn = module.alb.target_group_arn
  key_name         = var.key_name
  ami_id           = var.ami_id
  instance_type    = var.instance_type
  asg_sg_id        = module.security_groups.asg_sg_id
  public_subnets   = module.vpc.public_subnets



}

module "compute" {
  source                  = "./module/compute"
  ami_id                  = var.ami_id
  tags                    = local.luxe_tags
  instance_type           = var.instance_type
  key_name                = var.key_name
  bastion_host_sg         = module.security_groups.bastion_host_sg
  luxe_private_subnets    = module.vpc.luxe_private_subnets
  luxe_private_servers_sg = module.security_groups.luxe_private_servers_sg
  public_subnets          = module.vpc.public_subnets
}


module "dns" {
  source       = "./module/dns"
  luxe_alb_id  = module.alb.luxe_alb_id
  alb_dns_name = module.alb.alb_dns_name
}


module "database" {
  source            = "./module/database"
  allocated_storage = var.allocated_storage
  db_name           = var.db_name
  instance_class    = var.instance_class
  username          = var.username
  secret_name       = var.secret_name
  tags              = local.luxe_tags
  luxe_db_sg        = module.security_groups.luxe_db_sg
  luxe_db_subnets   = module.vpc.luxe_db_subnets
}
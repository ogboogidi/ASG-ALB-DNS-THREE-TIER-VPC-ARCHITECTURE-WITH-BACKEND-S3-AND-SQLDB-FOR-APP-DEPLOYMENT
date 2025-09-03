variable "public_subnets" {
  type = list(string)
}

variable "vpc_id" {
  type = string
}

variable "alb_sg_id" {
  type = string
}

variable "tags" {
  type = map(string)
}


variable "luxe_asg_id" {
  type = string
}
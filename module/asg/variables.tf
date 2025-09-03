variable "target_group_arn" {
  type = string
}

variable "key_name" {
  type = string
}

variable "ami_id" {
  type = string
}

variable "instance_type" {
  type = string
}

variable "asg_sg_id" {
  type = string
}

variable "public_subnets" {
  type = list(string)
}

variable "tags" {
  type = map(string)
}
variable "ami_id" {
  type = string
}

variable "instance_type" {
  type = string
}

variable "key_name" {
  type = string
}

variable "bastion_host_sg" {
  type = string
}

variable "tags" {
  type = map(string)
}

variable "luxe_private_subnets" {
  type = map(string)
}

variable "luxe_private_servers_sg" {
  type = string
}

variable "public_subnets" {
  type = list(string)
}
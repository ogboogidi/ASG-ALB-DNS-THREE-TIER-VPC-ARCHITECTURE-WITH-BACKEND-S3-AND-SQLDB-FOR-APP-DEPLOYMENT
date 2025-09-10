variable "cidr_block" {
  type = string
}

variable "availability_zones" {
  type = list(string)
}

variable "public_subnet_cidr_block" {
  type = list(string)
}

variable "private_subnet_cidr_block" {
  type = list(string)
}

variable "db_private_subnet_cidr_block" {
  type = list(string)
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

#db variables
variable "allocated_storage" {
  type = number
}

variable "db_name" {
  type = string
}

variable "instance_class" {
  type = string
}

variable "username" {
  type = string
}

variable "secret_name" {
  type = string
}
variable "cidr_block" {
  type = string
}

variable "tags" {
  type = map(string)
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
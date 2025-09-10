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

variable "luxe_db_sg" {
  type = string
}

variable "luxe_db_subnets" {
  type = list(string)
}

variable "secret_name" {
  type = string
}

variable "tags" {
  type = map(string)
}
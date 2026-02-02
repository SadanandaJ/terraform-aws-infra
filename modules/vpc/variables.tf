variable "name" {}
variable "vpc_cidr" {}
variable "public_subnet_cidr" {}
variable "private_subnet_cidr" {}
variable "az" {}
variable "public_subnet_cidrs" {
  type = list(string)
}

variable "azs" {
  type = list(string)
}


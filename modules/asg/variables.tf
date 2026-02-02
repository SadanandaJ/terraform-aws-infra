variable "ami_id" {}
variable "instance_type" {}
variable "key_name" {}
variable "private_subnets" { type = list(string) }
variable "target_group_arn" {}
variable "min" {}
variable "max" {}
variable "desired" {}
variable "user_data" {}


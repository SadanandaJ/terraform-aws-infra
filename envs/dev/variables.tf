variable "ami_id" {
  description = "AMI ID for EC2 instances"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
}

variable "key_name" {
  description = "EC2 key pair name"
  type        = string
}

variable "min" {
  description = "Minimum ASG size"
  type        = number
}

variable "max" {
  description = "Maximum ASG size"
  type        = number
}

variable "desired" {
  description = "Desired ASG capacity"
  type        = number
}


provider "aws" {
  region = "us-east-1"
}

module "vpc" {
  source               = "../../modules/vpc"
  name                 = "dev-vpc"
  vpc_cidr             = "10.0.0.0/16"
  public_subnet_cidrs  = ["10.0.1.0/24", "10.0.2.0/24"]   # list
  private_subnet_cidrs = ["10.0.101.0/24", "10.0.102.0/24"] # list
  azs                  = ["us-east-1a", "us-east-1b"]      # list
}


resource "aws_security_group" "alb_sg" {
  vpc_id = module.vpc.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

module "alb" {
  source         = "../../modules/alb"
  name           = "dev-alb"
  vpc_id         = module.vpc.vpc_id
  public_subnets = module.vpc.public_subnet_ids   # <- use plural output
  sg_id          = aws_security_group.alb_sg.id
}

module "asg" {
  source          = "../../modules/asg"
  ami_id          = var.ami_id
  instance_type   = var.instance_type
  key_name        = var.key_name
  private_subnets = module.vpc.private_subnet_ids  # <- use plural output
  target_group_arn = module.alb.target_group_arn
  min             = var.min
  max             = var.max
  desired         = var.desired
  user_data       = file("${path.module}/user_data.sh")
}


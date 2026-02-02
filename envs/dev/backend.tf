terraform {
  backend "s3" {
    bucket         = "terraform-state-sadananda143-dev-98231"
    key            = "dev/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-lock"
    encrypt        = true
  }
}


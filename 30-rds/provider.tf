terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = ">= 5.92.0"
    }
  }

  backend "s3" {
    bucket = "81s-remote-state-teja"
    key    = "expense-rds-dev"
    region = "eu-west-1"
    dynamodb_table = "81s-locking-teja"
  }
}

provider "aws" {
  # Configuration options
  region = "eu-west-1"
}

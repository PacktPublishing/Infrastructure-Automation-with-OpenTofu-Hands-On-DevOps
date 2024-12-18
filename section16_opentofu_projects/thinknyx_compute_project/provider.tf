terraform {
  backend "s3" {
    bucket         = "thinknyx-dev"
    key            = "terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "thinknyx_dynamodb_lock_table"
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.39.0"
    }
    tls = {
      source = "hashicorp/tls"
      version = "4.0.5"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

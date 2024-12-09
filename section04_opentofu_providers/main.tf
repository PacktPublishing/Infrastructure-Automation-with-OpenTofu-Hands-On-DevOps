terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~>4.0"
    }
    local = {
      source  = "hashicorp/local"
      version = "=2.4.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

provider "local" {}

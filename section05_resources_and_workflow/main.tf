terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~>4.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "thinknyxserver" {
  ami           = "ami-0440d3b780d96b29d"
  instance_type = "t2.small"

  tags = {
    Name = "thinknyxserver"
  }
}

resource "aws_eip" "thinknyxeip" {}

resource "aws_eip_association" "thinknyxeip_assoc" {
  instance_id   = aws_instance.thinknyxserver.id
  allocation_id = aws_eip.thinknyxeip.id
}

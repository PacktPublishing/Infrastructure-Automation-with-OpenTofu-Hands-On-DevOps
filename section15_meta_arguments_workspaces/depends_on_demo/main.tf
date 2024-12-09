resource "aws_instance" "thinknyxserver" {
  ami           = "ami-0440d3b780d96b29d"
  instance_type = "t2.micro"
  availability_zone = "us-east-1a"
  tags = local.project_tags
  depends_on = [
    aws_ebs_volume.thinknyxvolume
  ]
}

resource "aws_ebs_volume" "thinknyxvolume" {
  size = 1
  type = "standard" 
  availability_zone = "us-east-1a"
  tags = local.project_tags
}

locals {
  project_tags = {
    Name = "tofulocalblockdemo"
  }
}
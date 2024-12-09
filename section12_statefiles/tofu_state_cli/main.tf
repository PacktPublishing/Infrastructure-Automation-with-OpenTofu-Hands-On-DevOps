provider "aws" {
  region = "us-east-1"
}

data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-*-amd64-server-*"]
  }
}

resource "aws_instance" "myawsserver" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"

  tags = {
    Name       = "udemycourse"
    coursename = "OpenTofuCourse"
    release    = "March24"
  }
}

//resource "aws_eip" "extraip" {}

output "instance_public_ip" {
  value       = "My server IP is ${aws_instance.myawsserver.public_ip}"
  description = "Displays the public IP address of the instance"
}
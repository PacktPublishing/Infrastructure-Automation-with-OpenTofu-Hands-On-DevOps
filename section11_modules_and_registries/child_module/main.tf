data "aws_ami" "ubuntu" {
  most_recent = true
  owners = ["099720109477"]
  filter {
    name = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-*-amd64-server-*"]
  }
}


resource "aws_instance" "thinknyxserver" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.instance_types["small"]

  tags = {
    Name = var.instance_name
  }

  key_name = var.private_keyname

 
}


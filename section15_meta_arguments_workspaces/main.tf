resource "aws_instance" "thinknyxserver" {
  ami           = "ami-030ff268bd7b4e8b5"
  instance_type = "t2.micro"

  tags = {
    Name = "tofuserver"
  }

  lifecycle {
    ignore_changes = [
      tags  
    ]
  }
}
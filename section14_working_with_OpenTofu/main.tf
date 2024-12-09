resource "aws_instance" "thinknyxserver" {
  ami           = "ami-0440d3b780d96b29d"
  instance_type = "t2.micro"

  tags = {
    Name = "thinknyxserver"
  }
  timeouts {
    create = "20m"
    update = "20m"
  }
}
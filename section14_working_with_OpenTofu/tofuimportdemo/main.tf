resource "aws_instance" "testserver" {
  ami = "ami-0440d3b780d96b29d"
  instance_type = "t2.micro"
  tags = {
    Name = "tofuimportdemo"
  }
}

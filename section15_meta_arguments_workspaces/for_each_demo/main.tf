resource "aws_instance" "thinknyxserver" {
  ami           = "ami-030ff268bd7b4e8b5"
  instance_type = "t2.micro"

  tags = {
    Name = each.value
  }
  for_each = var.servername
}

variable "servername" {
  type = map(string)
  default = {
    one = "demoone",
    two = "demotwo",
    three = "demothree",
  }
}
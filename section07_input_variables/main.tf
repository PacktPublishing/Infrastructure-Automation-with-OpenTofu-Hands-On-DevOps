resource "aws_instance" "thinknyxserver" {
  ami           = var.image_id
  instance_type = var.instance_types["small"]

  tags = {
    Name = var.instance_name
  }
}


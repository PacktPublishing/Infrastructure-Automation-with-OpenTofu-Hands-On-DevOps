resource "tls_private_key" "thinknyx_private_key" {
  algorithm = "RSA"
}

resource "aws_key_pair" "opentofu_generated_key" {
  key_name = var.key_name
  public_key = tls_private_key.thinknyx_private_key.public_key_openssh
}

resource "local_file" "thinknyx_opentofu_key" {
  filename = "${var.key_name}.pem"
  content = tls_private_key.thinknyx_private_key.private_key_pem
}

resource "aws_instance" "thinknyx_web_server" {
  ami                         = "ami-07d9b9ddc6cd8dd30"
  instance_type               = "t2.micro"
  subnet_id                   = aws_subnet.thinknyx_public_subnet[0].id
  vpc_security_group_ids      = [aws_security_group.thinknyx_security_group.id]
  key_name = aws_key_pair.opentofu_generated_key.key_name
  
  tags = {
    Name = "thinknyx_web_server"
  }
   connection {
    type        = "ssh"
    host        = self.public_ip
    user        = "ubuntu"
    private_key = file(local_file.thinknyx_opentofu_key.filename)
  }

  provisioner "remote-exec" {
    inline = ["nc -zv -w 1 -i 1 ${aws_instance.thinknyx_db_server.private_ip} 22"]
  }
}

resource "aws_instance" "thinknyx_db_server" {
  ami                    = "ami-07d9b9ddc6cd8dd30"
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.thinknyx_private_subnet[1].id
  vpc_security_group_ids = [aws_security_group.thinknyx_security_group.id]
  key_name = aws_key_pair.opentofu_generated_key.key_name

  tags = {
    Name = "thinknyx_db_server"
  }
 
}

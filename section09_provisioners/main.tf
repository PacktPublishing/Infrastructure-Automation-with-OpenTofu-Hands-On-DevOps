resource "aws_instance" "thinknyxserver" {
  ami           = var.image_id
  instance_type = var.instance_types["small"]

  tags = {
    Name = var.instance_name
  }

  key_name = var.private_keyname

  connection {
    type        = "ssh"
    host        = self.public_ip
    user        = "ubuntu"
    private_key = file(var.aws_key)
  }

  provisioner "file" {
    source = "thinknyx.txt"
    destination = "/tmp/thinknyx.txt"
  }

  /*provisioner "remote-exec" {
    inline = ["sudo apt update", " sudo apt install -y nginx", "sudo systemctl start nginx", "sudo systemctl enable nginx"]
  }*/

  /* provisioner "local-exec" {
    when = destroy
    command = "echo 'Instance deleted'"
  } */
}


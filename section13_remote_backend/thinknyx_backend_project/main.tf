resource "aws_instance" "thinknyxdemo" {
    ami = "ami-07d9b9ddc6cd8dd30"
    instance_type = "t2.micro"

    tags = {
        Name = "demoserver"
    }
}
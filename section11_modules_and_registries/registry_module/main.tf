module "aws_instance" {
    source = "adeepthinarayan/ec2-instance-provisioning/aws"
    version = "1.0.1"
    private_keyname = "dummy"
}
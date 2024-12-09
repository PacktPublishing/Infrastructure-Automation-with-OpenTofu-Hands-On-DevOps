module "ec2-module" {
    source = "../child_module"
    instance_name = "demoserver"
    private_keyname = "dummy"
}
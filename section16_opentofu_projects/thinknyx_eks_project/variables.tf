variable "cidr_block" {
  default = "10"
}
variable "Name" {
  default = "thinknyx-opentofu-course"
}

variable "cluster_role" {
  type = map(any)
  default = {
    role_name = "cluster_role"
    service   = "eks"
  }
}
variable "ec2_role" {
  default = ["node_role", "access_role"]
}
variable "cluster_name" {
  default = "eks_cluster"
}

variable "cluster_compute" {
  type = map(any)
  default = {
    instance_types = "t3.medium"
    desired_size = 2
    max_size       = 3
    min_size       = 1
    ec2_ssh_key    = "dummy"
  }
}


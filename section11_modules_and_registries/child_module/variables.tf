variable "instance_types" {
  default = {
    "small"  = "t2.micro"
    "medium" = "m5.large"
    "large"  = "c5.xlarge"
  }
  type        = map(string)
  description = "A map of instance types to choose from."
}

variable "instance_name" {
  default = "thinknyxserver"
  type    = string
}

variable "aws_regions" {
  default     = ["us-west-1", "us-east-1", "eu-west-1", "ap-southeast2"]
  type        = list(string)
  description = "A list of AWS regions where resources will be deployed."
}

variable "private_keyname" {}


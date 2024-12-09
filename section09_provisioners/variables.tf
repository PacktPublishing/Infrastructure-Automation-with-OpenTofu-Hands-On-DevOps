variable "image_id" {
  default     = "ami-0c7217cdde317cfec"
  type        = string
  description = "The identifier of the machine image used for the server."
  validation {
    condition     = length(var.image_id) > 4 && substr(var.image_id, 0, 4) == "ami-"
    error_message = "The image_id value must be a valid AMI id, starting with \"ami-\"."
  }
  nullable = false
}

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

variable "private_keyname" {
  default = "dummy"
}

variable "aws_key" {
  default = "dummy.pem"
}
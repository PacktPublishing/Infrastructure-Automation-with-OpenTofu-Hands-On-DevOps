output "instance_public_ip" {
  value       = "My server IP is ${aws_instance.thinknyxserver.public_ip}"
  description = "Displays the public IP address of the instance."
}
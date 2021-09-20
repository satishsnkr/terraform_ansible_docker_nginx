output "instance_ips" {
  value = aws_instance.app_vm.public_ip
}
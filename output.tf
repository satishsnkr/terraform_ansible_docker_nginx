output "instance_ips" {
  value = aws_instance.app_vm.public_ip
}

output "vm_public_ip" {
    value = aws_eip.elastic_ip.public_ip
}
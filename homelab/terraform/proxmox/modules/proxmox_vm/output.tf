output "instance_ip_addr" {
  value = proxmox_vm_qemu.generate_vm.nameserver
}
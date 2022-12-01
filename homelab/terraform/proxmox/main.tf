module "proxmox_vm-k3s-1" {
  source   = "./modules/proxmox_vm"

  hostname      = "k3s-1"
  order         = 1
  ipv4_address  = "192.168.1.20"
  live_ip       = "192.168.1.5"
}

module "proxmox_vm-k3s-2" {
  source   = "./modules/proxmox_vm"

  hostname      = "k3s-2"
  order         = 2
  ipv4_address  = "192.168.1.21"
  live_ip       = module.proxmox_vm-k3s-1.instance_ip_addr
}

module "proxmox_vm-k3s-3" {
  source   = "./modules/proxmox_vm"

  hostname      = "k3s-3"
  order         = 3
  ipv4_address  = "192.168.1.22"
  live_ip       = module.proxmox_vm-k3s-2.instance_ip_addr
}

terraform {
  required_providers {
    proxmox = {
      source  = "telmate/proxmox"
      version = "2.9.11"
    }
  }
}

provider "proxmox" {
  pm_api_url = "https://pve.stiil.local:8006/api2/json"
}

resource "proxmox_vm_qemu" "generate_vm" {
  name        = var.hostname
  desc        = "tf description"
  target_node = "pve"

  clone = "ubuntu-22.10-20221101"

  disk{
    type = "scsi"
    storage = "local-lvm"
	size = "128G"
  }
  
  cores   = 8
  sockets = 1
  memory  = 8192

  onboot = true
  startup = format("order=%s", var.order)
  
  network {
    model  = "virtio"
    bridge = "vmbr0"
  }

  ssh_user        = "root"

  os_type      = "cloud-init"
  ipconfig0    = format("ip=%s/24,gw=192.168.1.1", var.ipv4_address)
  nameserver   = "192.168.1.5"
  searchdomain = "stiil.dk"

  sshkeys = <<EOF
ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJJOy0AAWu1qB9rtsFtW3IDWgORXSIkWT6GwSbTvYhB8 ansible@Klodsen
ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJgWqR24oohs6sHEt5dxi134BbnOnzPYhnynWoRq8BBp simon@Klodsen
EOF

  connection {
	type        = "ssh"
	user        = "ubuntu"
	private_key = <<EOF
-----BEGIN OPENSSH PRIVATE KEY-----
b3BlbnNzaC1rZXktdjEAAAAABG5vbmUAAAAEbm9uZQAAAAAAAAABAAAAMwAAAAtzc2gtZW
QyNTUxOQAAACCSTstAAFrtagfa7bBbVtyA1oDkV0iJFk+hsEm072IQfAAAAJBvvZuub72b
rgAAAAtzc2gtZWQyNTUxOQAAACCSTstAAFrtagfa7bBbVtyA1oDkV0iJFk+hsEm072IQfA
AAAEDulf+asyh/RralzPaiUllfZDb/5NcCOtswbMH/mSKpL5JOy0AAWu1qB9rtsFtW3IDW
gORXSIkWT6GwSbTvYhB8AAAADXNpbW9uQEtsb2RzZW4=
-----END OPENSSH PRIVATE KEY-----
EOF
    host = var.ipv4_address
  }
  provisioner "remote-exec" {
    inline = [
      "ip a",
      format("ping -c 1 %s", var.live_ip)
    ]
  }
}
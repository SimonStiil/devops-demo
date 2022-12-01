#!/bin/bash
read  -n 1 -p "Destroy Proxmox (y/n):" mainmenuinput
if [ $? != 0 ]; then
  exit
fi 
if [ "$mainmenuinput" = "y" ]; then
  echo "# (cd terraform/proxmox/ && terraform destroy -auto-approve)"
  (cd terraform/proxmox/ && terraform destroy -auto-approve)
fi

echo "# (cd terraform/proxmox/ && terraform apply -auto-approve)"
read  -n 1 -p "continue?" mainmenuinput
if [ $? != 0 ]; then
  exit
fi 
(cd terraform/proxmox/ && terraform apply -auto-approve)

echo "# (cd ansible/k3s-ansible/ && ansible-playbook site.yml -i inventory/sample/hosts.ini)"
echo "# scp ubuntu@192.168.1.20:/home/ubuntu/.kube/config ~/.kube/config"
read  -n 1 -p "continue?" mainmenuinput
if [ $? != 0 ]; then
  exit
fi 
(cd ansible/k3s-ansible/ && ansible-playbook site.yml -i inventory/sample/hosts.ini)
mkdir -p ~/.kube
scp ubuntu@192.168.1.20:/home/ubuntu/.kube/config ~/.kube/config

echo "# (cd ansible/infrastucture/ && ansible-playbook site.yml -i inventory/sample/hosts.ini)"
read  -n 1 -p "continue?" mainmenuinput
if [ $? != 0 ]; then
  exit
fi 
(cd ansible/infrastucture/ && ansible-playbook site.yml -i inventory/sample/hosts.ini)

read  -n 1 -p "Clean Rancher State? (y/n):" mainmenuinput
if [ $? != 0 ]; then
  exit
fi
if [ "$mainmenuinput" = "y" ]; then
  echo "# (cd terraform/rancher/ && rm terraform.tfstate terraform.tfstate.backup )"
  (cd terraform/rancher/ && rm terraform.tfstate terraform.tfstate.backup )
fi

echo "# (cd terraform/rancher/ && terraform apply -auto-approve)"
read  -n 1 -p "continue?" mainmenuinput
if [ $? != 0 ]; then
  exit
fi 
(cd terraform/rancher/ && terraform apply -auto-approve)

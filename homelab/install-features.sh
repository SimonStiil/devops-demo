echo "# (cd ansible/features/ && ansible-playbook site.yml -i inventory/sample/hosts.ini)"
read  -n 1 -p "continue?" mainmenuinput
if [ $? != 0 ]; then
  exit
fi 
(cd ansible/features/ && ansible-playbook site.yml -i inventory/sample/hosts.ini)
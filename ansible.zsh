ns=notify-send

alias a='ansible'
alias ap='ansible-playbook'
alias ani='ansible-inventory'
alias update-all='ansible-playbook ~/playbooks/update.yml && ns -u low "Updates for All Machines Complete"'
alias update-laptops='ansible-playbook ~/playbooks/laptops.yml'
alias inventory='sudo nvim /etc/ansible/hosts'

function add-all() {
    ansible machines:all -m community.general.pacman -a "name=$1"
}

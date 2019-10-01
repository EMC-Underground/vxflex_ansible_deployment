This ansible playbooks using ansible-galaxy roles to deploy a 3 node cluster of vxFlex

### Deployment Steps
1. Update the vars/vars.yml.example with your specific system information then rename the file to vars.yml
2. Update the hosts.example file with the correct server IP address and rename to hosts.
3. Remeber to copy your id rsa key to all hosts in the cluster with ssh-copy-id username@hostname
from the computer you are running the playbooks from


```shell
ansible-galaxy install -r requirements.yml
ansible-playbook playbook.yml -u <local_admin_account> -i hosts playbook.yml
```

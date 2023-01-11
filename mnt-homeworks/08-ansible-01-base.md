1   
```markdown
vagrant@server1:~/playbook$ ansible-playbook -i inventory/test.yml site.yml

PLAY [Print os facts] **************************************************************************************************

TASK [Gathering Facts] *************************************************************************************************
ok: [localhost]

TASK [Print OS] ********************************************************************************************************
ok: [localhost] => {
    "msg": "Ubuntu"
}

TASK [Print fact] ******************************************************************************************************
ok: [localhost] => {
    "msg": 12
}

PLAY RECAP *************************************************************************************************************
localhost                  : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
```
2   
```markdown
vagrant@server1:~/playbook$ cat group_vars/all/examp.yml
---
  some_fact: 12
vagrant@server1:~/playbook$ nano group_vars/all/examp.yml
vagrant@server1:~/playbook$ ansible-playbook -i inventory/test.yml site.yml

TASK [Print fact] ******************************************************************************************************
ok: [localhost] => {
    "msg": "all default fact"
}
```
```markdown

```
4   
```markdown
vagrant@vagrant:~/playbook$ ansible-playbook -i inventory/prod.yml site.yml

PLAY [Print os facts] **************************************************************************************************

TASK [Gathering Facts] *************************************************************************************************
ok: [centos_vm]
ok: [fedora_vm]

TASK [Print OS] ********************************************************************************************************
ok: [centos_vm] => {
    "msg": "CentOS"
}
ok: [fedora_vm] => {
    "msg": "Fedora"
}

TASK [Print fact] ******************************************************************************************************
ok: [centos_vm] => {
    "msg": "el"
}
ok: [fedora_vm] => {
    "msg": "Fed"

PLAY RECAP *************************************************************************************************************
centos_vm                  : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
fedora_vm                  : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
```

5
```markdown
vagrant@vagrant:~/playbook$ ansible-playbook -i inventory/prod.yml site.yml

PLAY [Print os facts] **************************************************************************************************

TASK [Gathering Facts] *************************************************************************************************
ok: [centos_vm]
ok: [fedora_vm]

TASK [Print OS] ********************************************************************************************************
ok: [centos_vm] => {
    "msg": "CentOS"
}
ok: [fedora_vm] => {
    "msg": "Fedora"
}

TASK [Print fact] ******************************************************************************************************
ok: [centos_vm] => {
    "msg": "el default fact"
}
ok: [fedora_vm] => {
    "msg": "fed default fact"
}

PLAY RECAP *************************************************************************************************************
centos_vm                  : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
fedora_vm                  : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
```

6, 7, 8   
```markdown
vagrant@vagrant:~/playbook$ ls group_vars/
all  deb  el  fed
vagrant@vagrant:~/playbook$ ansible-vault encrypt group_vars/el/examp.yml
New Vault password:
Confirm New Vault password:
Encryption successful
vagrant@vagrant:~/playbook$ ansible-vault encrypt group_vars/fed/examp.yml
New Vault password:
Confirm New Vault password:
Encryption successful
vagrant@vagrant:~/playbook$ ansible-playbook -i inventory/prod.yml site.yml --ask-vault-pass
Vault password:

PLAY [Print os facts] **************************************************************************************************

TASK [Gathering Facts] *************************************************************************************************
ok: [centos_vm]
ok: [fedora_vm]

TASK [Print OS] ********************************************************************************************************
ok: [centos_vm] => {
    "msg": "CentOS"
}
ok: [fedora_vm] => {
    "msg": "Fedora"
}

TASK [Print fact] ******************************************************************************************************
ok: [centos_vm] => {
    "msg": "el default fact"
}
ok: [fedora_vm] => {
    "msg": "fed default fact"
}

PLAY RECAP *************************************************************************************************************
centos_vm                  : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
fedora_vm                  : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
```

9, 10, 11  
Посмотрите при помощи ansible-doc список плагинов для подключения. Выберите подходящий для работы на control node.  
- 'local'

```markdown
vagrant@vagrant:~/playbook$ cat inventory/prod.yml
---
  el:
    hosts:
      centos_vm:
        ansible_connection: docker
  fed:
    hosts:
      fedora_vm:
        ansible_connection: docker
  local:
    hosts:
      localhost:
        ansible_connection: local
#  deb:
#    hosts:
#      ubuntu_vm:
#        ansible_connection: docker
```
```markdown
vagrant@vagrant:~/playbook$ ansible-playbook -i inventory/prod.yml site.yml --ask-vault-pass
Vault password:

PLAY [Print os facts] **************************************************************************************************

TASK [Gathering Facts] *************************************************************************************************
ok: [localhost]
ok: [fedora_vm]
ok: [centos_vm]

TASK [Print OS] ********************************************************************************************************
ok: [centos_vm] => {
    "msg": "CentOS"
}
ok: [localhost] => {
    "msg": "Ubuntu"
}
ok: [fedora_vm] => {
    "msg": "Fedora"
}

TASK [Print fact] ******************************************************************************************************
ok: [centos_vm] => {
    "msg": "el default fact"
}
ok: [localhost] => {
    "msg": 12
}
ok: [fedora_vm] => {
    "msg": "fed default fact"
}

PLAY RECAP *************************************************************************************************************
centos_vm                  : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
fedora_vm                  : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
localhost                  : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
```
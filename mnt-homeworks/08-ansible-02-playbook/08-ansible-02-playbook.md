1) При выполнении домашнего задания возникла ошибка как решить её?
```yaml
king@pow0555:~/devops-netology/mnt-homeworks/08-ansible-02-playbook/playbook$ ansible-playbook site.yml

PLAY [Install Clickhouse] ***************************************************************************************************************************************************************************************

TASK [Gathering Facts] *************************************************************************************************
ok: [clickhouse-01]

TASK [Clickhouse | Get clickhouse distrib] *****************************************************************************
changed: [clickhouse-01] => (item=clickhouse-client)
changed: [clickhouse-01] => (item=clickhouse-server)
failed: [clickhouse-01] (item=clickhouse-common-static) => {"ansible_loop_var": "item", "changed": false, "dest":
  "./clickhouse-common-static-22.3.3.44.rpm", "elapsed": 0, "item": "clickhouse-common-static", "msg": "Request failed",
"response": "HTTP Error 404: Not Found", "status_code":
404,  "url": "https://packages.clickhouse.com/rpm/stable/clickhouse-common-static-22.3.3.44.noarch.rpm"}

TASK [Clickhouse | Get clickhouse distrib] *****************************************************************************
changed: [clickhouse-01]

TASK [Clickhouse | Install clickhouse packages] ************************************************************************
fatal: [clickhouse-01]: FAILED! => {"changed": false, "msg": "Unsupported parameters for (ansible.builtin.apt) module:
disable_gpg_check. Supported parameters include: clean, default_release (default-release), autoremove, dpkg_options,
upgrade, only_upgrade, allow_unauthenticated (allow-unauthenticated), fail_on_autoremove, force_apt_get,
allow_change_held_packages, update_cache_retries, update_cache_retry_max_delay, cache_valid_time, update_cache (update-cache),
install_recommends (install-recommends), force, policy_rc_d, purge, state, allow_downgrade (allow-downgrade, allow-downgrades,
allow_downgrades), autoclean, deb, lock_timeout, package (name, pkg)."}

PLAY RECAP *************************************************************************************************************
clickhouse-01              : ok=2    changed=1    unreachable=0    failed=1    skipped=0    rescued=1    ignored=0
```

Вот эта ошибка я так понимаю ни на что не влияет, просто не может найти файл такой (в репе нет такого файла по этому и не скачивается )
```yaml
failed: [clickhouse-01] (item=clickhouse-common-static) => {"ansible_loop_var": "item", "changed": false, "dest":
  "./clickhouse-common-static-22.3.3.44.rpm", "elapsed": 0, "item": "clickhouse-common-static", "msg": "Request failed",
"response": "HTTP Error 404: Not Found", "status_code":
404,  "url": "https://packages.clickhouse.com/rpm/stable/clickhouse-common-static-22.3.3.44.noarch.rpm"}
```

Вот в это блоке сначала была вот такая ошибка TASK [Clickhouse | Install clickhouse packages]
```yaml
TASK [Clickhouse | Install clickhouse packages]
fatal: [clickhouse-01]: FAILED! => {"ansible_facts": {"pkg_mgr": "apt"}, "changed": false, "msg":
["Could not detect which major revision of yum is in use, which is required to determine module backend.",
"You should manually specify use_backend to tell the module whether to use the yum (yum3) or dnf (yum4) backend})"]}
```

Потом я поменял вот эту строчку "ansible.builtin.yum" на "ansible.builtin.apt" и ошибка стала такой.

```yaml
TASK [Clickhouse | Install clickhouse packages] ************************************************************************
fatal: [clickhouse-01]: FAILED! => {"changed": false, "msg": "Unsupported parameters for (ansible.builtin.apt) module:
disable_gpg_check. Supported parameters include: clean, default_release (default-release), autoremove, dpkg_options,
upgrade, only_upgrade, allow_unauthenticated (allow-unauthenticated), fail_on_autoremove, force_apt_get,
allow_change_held_packages, update_cache_retries, update_cache_retry_max_delay, cache_valid_time, update_cache (update-cache),
install_recommends (install-recommends), force, policy_rc_d, purge, state, allow_downgrade (allow-downgrade, allow-downgrades,
allow_downgrades), autoclean, deb, lock_timeout, package (name, pkg)."}
```
На сервер который послаю все все скачиватся
```markdown
vagrant@Server1:~$ ll
total 240680
drwxr-xr-x 7 vagrant vagrant      4096 Jan 26 03:06 ./
drwxr-xr-x 4 root    root         4096 Jan 24 06:40 ../
drwx------ 3 vagrant vagrant      4096 Jan 24 07:01 .ansible/
-rw-r--r-- 1 vagrant vagrant       220 Jan  9 21:54 .bash_logout
-rw-r--r-- 1 vagrant vagrant      3771 Jan  9 21:54 .bashrc
drwx------ 2 vagrant vagrant      4096 Jan 24 06:40 .cache/
drwxrwxr-x 3 vagrant vagrant      4096 Jan 24 06:59 .local/
-rw-r--r-- 1 vagrant vagrant       807 Jan  9 21:54 .profile
drwx------ 2 vagrant vagrant      4096 Jan 24 06:59 .ssh/
-rw-rw-r-- 1 vagrant vagrant     38090 Jan 26 03:06 clickhouse-client-22.3.3.44.rpm
-rw-rw-r-- 1 vagrant vagrant 246310036 Jan 26 03:06 clickhouse-common-static-22.3.3.44.rpm
-rw-rw-r-- 1 vagrant vagrant     61151 Jan 26 03:06 clickhouse-server-22.3.3.44.rpm

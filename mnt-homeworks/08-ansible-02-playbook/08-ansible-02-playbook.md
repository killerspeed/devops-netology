1)  Делаю все на ubuntu поменял  блок [Install clickhouse packages] на 

```yaml
    - name: Install clickhouse packages
      apt:
        deb: "{{ item }}"
      with_items: "{{ clickhouse_packages }}-{{ clickhouse_version }}.deb"
```
При это блоке ошибка вот такая , я понимаю  что не видит файл , но как это исправить не могу найти 

```markdown
TASK [Install clickhouse packages] *************************************************************************************
failed: [clickhouse-01] (item=['clickhouse-common-static', 'clickhouse-client', 'clickhouse-server']-22.1.4.30.deb) => 
{"ansible_loop_var": "item", "changed": false, "item": "['clickhouse-common-static', 'clickhouse-client', 
'clickhouse-server']-22.1.4.30.deb", "msg": "Unable to install package: E:Could not open file ['clickhouse-common-static' 
- open (2: No such file or directory)"}
```

Был
```yaml
    - name: Clickhouse | Install clickhouse packages
      become: true
      ansible.builtin.apt:
        name:
          - ./clickhouse-common-static-{{ clickhouse_version }}.rpm
          - ./clickhouse-client-{{ clickhouse_version }}.rpm
          - ./clickhouse-server-{{ clickhouse_version }}.rpm
```

```markdown
vagrant@Server2:~$ ll
total 210624
drwxr-xr-x 6 vagrant vagrant      4096 Feb  1 05:35 ./
drwxr-xr-x 4 root    root         4096 Jan 24 06:47 ../
drwx------ 3 vagrant vagrant      4096 Jan 24 07:31 .ansible/
-rw-r--r-- 1 vagrant vagrant       220 Jan  9 21:54 .bash_logout
-rw-r--r-- 1 vagrant vagrant      3771 Jan  9 21:54 .bashrc
drwx------ 2 vagrant vagrant      4096 Jan 24 06:47 .cache/
drwxrwxr-x 3 vagrant vagrant      4096 Jan 24 06:59 .local/
-rw-r--r-- 1 vagrant vagrant       807 Jan  9 21:54 .profile
drwx------ 2 vagrant vagrant      4096 Jan 24 06:59 .ssh/
-rw-rw-r-- 1 vagrant vagrant    124404 Feb  1 05:34 clickhouse-client-22.1.4.30.deb
-rw-rw-r-- 1 vagrant vagrant 215363644 Feb  1 05:35 clickhouse-common-static-22.1.4.30.deb
-rw-rw-r-- 1 vagrant vagrant    146818 Feb  1 05:34 clickhouse-server-22.1.4.30.deb
```
 
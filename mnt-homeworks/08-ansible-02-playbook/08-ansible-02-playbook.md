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

 
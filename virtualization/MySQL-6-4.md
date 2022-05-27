1  
Cnfnec
```markdown
mysql> status
--------------
mysql  Ver 8.0.29 for Linux on x86_64 (MySQL Community Server - GPL)

Connection id:          19
Current database:       test_db
Current user:           root@localhost
SSL:                    Not in use
Current pager:          stdout
Using outfile:          ''
Using delimiter:        ;
Server version:         8.0.29 MySQL Community Server - GPL
Protocol version:       10
Connection:             Localhost via UNIX socket
Server characterset:    utf8mb4
Db     characterset:    utf8mb3
Client characterset:    latin1
Conn.  characterset:    latin1
UNIX socket:            /var/run/mysqld/mysqld.sock
Binary data as:         Hexadecimal
Uptime:                 16 min 14 sec

Threads: 3  Questions: 63  Slow queries: 0  Opens: 170  Flush tables: 3  Open tables: 88  Queries per second avg: 0.064

Note that you are running in safe_update_mode:
UPDATEs and DELETEs that don't use a key in the WHERE clause are not allowed.
(One can force an UPDATE/DELETE by adding LIMIT # at the end of the command.)
SELECT has an automatic 'LIMIT 1000' if LIMIT is not used.
Max number of examined row combination in a join is set to: 1000000

--------------
```
Список таблиц

```markdown
Список таблиц

mysql> show tables;
+-------------------+
| Tables_in_test_db |
+-------------------+
| orders            |
+-------------------+
1 row in set (0.01 sec)
```

количество записей с price > 300.

```markdown
mysql> select count(*) from orders where price>300;
+----------+
| count(*) |
+----------+
|        1 |
+----------+
1 row in set (0.00 sec)

mysql>
```

2  
Создание пользователя 

```markdown
mysql> create user 'test'@'localhost'
    ->     identified with mysql_native_password by 'test-pass'
    ->     with max_queries_per_hour 100
    ->     password expire interval 180 day
    ->     failed_login_attempts 3
    ->     attribute '{"fname": "James","lname": "Pretty"}';
Query OK, 0 rows affected (0.01 sec)

```
Предоставьте привелегии пользователю test на операции SELECT

```markdown
mysql> GRANT SELECT ON test_db . * TO 'test'@'localhost';
Query OK, 0 rows affected, 1 warning (0.00 sec)
```
Получите данные по пользователю test

```markdown
mysql> select * FROM INFORMATION_SCHEMA.USER_ATTRIBUTES where user='test';
+------+-----------+---------------------------------------+
| USER | HOST      | ATTRIBUTE                             |
+------+-----------+---------------------------------------+
| test | localhost | {"fname": "James", "lname": "Pretty"} |
+------+-----------+---------------------------------------+
1 row in set (0.00 sec)
```

3  

Информация по engine

```markdown
mysql> SET profiling = 1;
Query OK, 0 rows affected, 1 warning (0.00 sec)
```
```markdown
mysql> SHOW PROFILES;
+----------+------------+----------------------------------+
| Query_ID | Duration   | Query                            |
+----------+------------+----------------------------------+
|        1 | 0.00013775 | SELECT @@profiling               |
|        2 | 0.01429025 | ALTER TABLE orders Engine=MyIsam |
|        3 | 0.01679525 | ALTER TABLE orders Engine=InnoDB |
+----------+------------+----------------------------------+
3 rows in set, 1 warning (0.00 sec)
```

4  
послдение не получаеться сделать пишет, как это исправить?
```
root@38b4ea1db906:/etc/mysql# nano my.cnf
bash: nano: command not found
```
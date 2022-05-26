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
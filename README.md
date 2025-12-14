# Learning-SQL
This repository contains resources and exercises for learning SQL (Structured Query Language). SQL is a standard language for managing and manipulating relational databases.

## Quick start
- go to [https://github.com/sudovinay01/Learning-SQL](https://github.com/sudovinay01/Learning-SQL)
- click on the green button `Code` -> `Codespaces` -> `Create codespace on main`
![quickstart.png](<images/quickstart.png>)
- wait for the codespace to load
- select `SQL Serve` in left panel -> `+ Add Connection` -> fill in the details as below:
![addconnection.png](<images/AddConnection.png>)
  - Profile Name: `Learning-SQL`
  - Server name: `localhost`
  - Authentication Type: `SQL Login`
  - User Name: `sa`
  - Password: `YourStrong!Passw0rd987` (check save password box for future use)
  - Encrypt: `Optional`
- Cick `Connect` button. You can see a new connection created in left panel.
![connectioncreated.png](<images/ConnectionEntry.png>)
- Now we can test connection by running _test.sql file. 
![testconnection.png](<images/testconnection.png>)
- You can run whatever sql queries you want in a `.sql` files.

## Topics Covered
- [ ] Types of SQL commands
  - [ ] Data Definition Language (DDL)
    - [x] [CREATE and DROP](Topics/DDL/01_CREATE_DROP.sql)
    - [x] [CREATE using existing table](Topics/DDL/02_CREATE_FROM_TABLE.sql)
    - [x] [ALTER](Topics/DDL/03_ALTER.sql)
    - [x] [TRUNCATE](Topics/DDL/04_TRUNCATE.sql)
    - [x] [COMMENTS](Topics/DDL/05_COMMENTS.sql)
  - [ ] Data Manipulation Language (DML)
  - [ ] Data Query Language (DQL)
  - [ ] Data Control Language (DCL)
  - [ ] Transaction Control Language (TCL)
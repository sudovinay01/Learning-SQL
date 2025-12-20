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
  - [x] Data Definition Language (DDL)
    - [x] [CREATE and DROP](Topics/DDL/01_CREATE_DROP.sql)
    - [x] [CREATE using existing table](Topics/DDL/02_CREATE_FROM_TABLE.sql)
    - [x] [ALTER](Topics/DDL/03_ALTER.sql)
    - [x] [TRUNCATE](Topics/DDL/04_TRUNCATE.sql)
    - [x] [COMMENTS](Topics/DDL/05_COMMENTS.sql)
    - [x] [RENAME](Topics/DDL/06_RENAME.sql)
  - [x] Data Manipulation Language (DML)
    - [x] [INSERT](Topics/DML/01_INSERT.sql)
    - [x] [UPDATE](Topics/DML/02_UPDATE.sql)
    - [x] [DELETE](Topics/DML/03_DELETE.sql)
    - [x] [MERGE](Topics/DML/04_MERGE.sql)
  - [x] Data Query Language (DQL)
    - [x] [SELECT](Topics/DQL/01_SELECT.sql)
    - [x] SQL Operators (can also be use for both DML and DQL)
      - [x] [Arithmetic Operators](Topics/DQL/SQL_Operators/01_ARTHMETIC.sql)
      - [x] [Comparison Operators and CASE](Topics/DQL/SQL_Operators/02_COMPARISON_AND_CASE.sql)
      - [x] [Logical Operators](Topics/DQL/SQL_Operators/03_LOGICAL.sql)
      - [x] [LIMIT/OFFSET](Topics/DQL/SQL_Operators/04_LIMIT_OFFSET.sql)
      - [x] [ORDER BY](Topics/DQL/SQL_Operators/05_ORDER_BY.sql)
      - [x] [GROUP BY](Topics/DQL/SQL_Operators/06_GROUP_BY.sql)
      - [x] [HAVING](Topics/DQL/SQL_Operators/07_HAVING.sql)
      - [x] [DISTINCT](Topics/DQL/SQL_Operators/08_DISTINCT.sql)
      - [x] [ALIASING](Topics/DQL/SQL_Operators/09_ALIASING.sql)
      - [x] [JOINs](Topics/DQL/SQL_Operators/11_JOINS.sql)
      - [x] [Subqueries](Topics/DQL/SQL_Operators/12_SUBQUERIES.sql)
  - [ ] Data Control Language (DCL)
  - [ ] Transaction Control Language (TCL)
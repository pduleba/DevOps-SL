# App-db layer :: MySQL 5.6

### How to run
* `exec-build.bat` - build Docker image 
* `exec-run.bat` - run container in shared network
* `exec-connect.bat` - connect to running container

### How to use
* `mysql -uroot -proot` to connect to DB
* `show databases;` to list available DBs
* `use app-db;` to set default DB
* `select * from orders;` to verify data inserted into DB

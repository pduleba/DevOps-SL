# App-rest-api layer :: Spring (Backend) + Angular (Frontend)

### How to run
* Make sure that `app-db` Docker container is running [See here for more](/app-db)
* `exec-run.bat` - run `app-rest-api` on Windows
* `exec-run.sh` - run `app-rest-api` on Linux
  * `exec-stop.sh` - stop `app-rest-api` on Linux

### How to use

#### RESTful API
* Import [DevOps.postman_collection.json](/util-postman/DevOps.postman_collection.json) Postman collection, where
  * `OrderController` contains CRUD for MySQL (RDS)
  * `S3Controller` contains
    * aws signedUrl generation
    * http put of object via generated signed url

#### Frontend
* Enter [MySQL/RDS Frontend](http://localhost:8080/app-rest/index)
* Enter [S3 Frontend](http://localhost:8080/app-rest/index)
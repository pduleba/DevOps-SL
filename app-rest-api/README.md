# App-rest-api layer :: Spring (Backend) + Angular (Frontend)

### How to run
* Make sure that `app-db` Docker container is running [See here for more](/app-db)
* `exec-build.bat` - build `app-rest-api`
* `exec-run.bat` - run `app-rest-api`

### How to use

#### RESTful API
* Import [DevOps.postman_collection.json](/util-postman/DevOps.postman_collection.json) Postman collection, where
  * `OrderController` contains CRUD for MySQL (RDS)
  * `S3Controller` contains
    * aws signedUrl generation
    * http put of object via generated signed url

#### Frontend
* Enter [MySQL/RDS Frontend](http://localhost:8080/app-rest/rds/index)
* Enter [S3 Frontend](http://localhost:8080/app-rest/s3/index)
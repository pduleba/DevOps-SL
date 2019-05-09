# App-rest-api layer :: Spring (Backend) + Angular (Frontend)

### How to run
* Make sure that `app-db` Docker container is running [See here for more](/app-db)
* `exec-build.bat` - build `app-rest-api`
* `exec-run.bat` - run `app-rest-api`

### How to use

#### RESTful API
* Import [DevOps.postman_collection.json](/util-postman/DevOps.postman_collection.json) Postman collection, where
  * `OrderController` contains API for RDS/MySQL
    * http `findAll` all entries in DB
    * http `findById` entry by id in DB
    * http `save` create/update by id from DB
    * http `delete` entry by id from DB
  * `S3Controller` contains API for AWS S3
    * http `findAll` all objects in S3
    * http `save` create/update object by key in S3
    * http `delete` object by key from S3
    * http `signedUrl` signed url generation for S3 http action

#### Frontend
* Enter [MySQL/RDS Frontend](http://localhost:8080/app-rest/rds/index)
* Enter [S3 Frontend](http://localhost:8080/app-rest/s3/index)
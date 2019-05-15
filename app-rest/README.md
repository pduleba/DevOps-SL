# app-rest layer :: Spring (Backend) + Angular (Frontend)

## How to

### build `Local` package
* Make sure that `app-db` Docker container is running [See here for more](/app-db)
* `exec-build-local.bat` - build `app-rest` using maven `local` profile
* run executable application ([See deployment-install for more](https://docs.spring.io/spring-boot/docs/current/reference/html/deployment-install.html))
### build `aws` package
* Make sure that AWS MySQL/AWS Aurora is running (version 5.6/8 compatible suggested)
* `exec-build-aws.bat` - build `app-rest` using maven `aws` profile
* run executable application ([See deployment-install for more](https://docs.spring.io/spring-boot/docs/current/reference/html/deployment-install.html))
### release package
* `exec-release.bat` - release `app-rest` using maven `aws` profile which includes
  * version update
  * create tag with sources on GitHub
  * executable `is not` released
### use `app-rest`
* RESTful API
  * Import [DevOps.postman_collection.json](/util-postman/DevOps.postman_collection.json) Postman collection, where
    * `RDSController` contains API for RDS/MySQL
      * http `ping` returns server status for health check purposes
      * http `findAll` all entries in DB
      * http `findById` entry by id in DB
      * http `save` create/update by id from DB
      * http `delete` entry by id from DB
    * `S3Controller` contains API for AWS S3
      * http `ping` returns server status for health check purposes
      * http `findAll` all objects in S3
      * http `save` create/update object by key in S3
      * http `delete` object by key from S3
      * http `signedUrl` signed url generation for S3 http action
* Frontend
  * Enter [MySQL/RDS Frontend](http://localhost:8080/app-rest/rds/index)
  * Enter [S3 Frontend](http://localhost:8080/app-rest/s3/index)
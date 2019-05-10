'use strict';

angular.module('s3').factory('S3Service',
    ['$localStorage', '$http', '$q', 'urls',
        function ($localStorage, $http, $q, urls) {

            self.s3requestTemplate = {
                "httpMethod": "PUT",
                "key": "",
                "params": {
                        "x-amz-acl":"private",
                        "x-amz-storage-class": "STANDARD_IA"
                }
            };

            var factory = {
                getAll: getAll,
                findAll: findAll,
                uploadS3Object: uploadS3Object,
                getSignedUrl: getSignedUrl,
                deleteS3Object: deleteS3Object
            };

            return factory;

            function getAll(){
                console.log('Service.GetAll :: From Local storage');
                return $localStorage.s3objects;
            }

            function findAll() {
                console.log('Service.FindAll');
                var deferred = $q.defer();
                $http.get(urls.S3_API + '/findAll')
                    .then(
                        function (response) {
                            console.log('Service.FindAll :: Complete');
                            $localStorage.s3objects = response.data.body;
                            console.log('Service.FindAll :: In Local storage');
                            deferred.resolve(response);
                        },
                        function (error) {
                            console.error('Service.FindAll :: Error :: ' + error.data.errorMessage);
                            deferred.reject(error);
                        }
                    );
                return deferred.promise;
            }

            function uploadS3Object(signedUrl, file) {
                console.log('Service.UploadS3Object');
                var deferred = $q.defer();
                $http.put(signedUrl, file)
                    .then(
                        function (response) {
                            console.log('Service.UploadS3Object :: Complete');
                            findAll();
                            console.log('Service.UploadS3Object :: Updating Complete');
                            deferred.resolve(response.data.body);
                        },
                        function (error) {
                            console.error('Service.UploadS3Object :: Error :: ' + error.data.errorMessage);
                            deferred.reject(error);
                        }
                    );
                return deferred.promise;
            }

            function getSignedUrl(key) {
                console.log('Service.SignedUrl');
                var deferred = $q.defer();
                self.s3requestTemplate.key = key;

                $http.post(urls.S3_API + '/signedUrl', s3requestTemplate)
                    .then(
                        function (response) {
                            console.log('Service.SignedUrl :: Complete');
                            deferred.resolve(response.data.body);
                        },
                        function (error) {
                            console.error('Service.SignedUrl :: Error :: ' + error.data.errorMessage);
                            deferred.reject(error);
                        }
                    );
                return deferred.promise;
            }

            function deleteS3Object(key) {
                console.log('Service.DeleteS3Object');
                var deferred = $q.defer();
                $http.delete(urls.S3_API + '/delete/' + key)
                    .then(
                        function (response) {
                            console.log('Service.DeleteS3Object :: Complete');
                            findAll();
                            console.log('Service.DeleteS3Object :: Updating Complete');
                            deferred.resolve(response.data.body);
                        },
                        function (error) {
                            console.error('Service.DeleteS3Object :: Error :: ' + error.data.errorMessage);
                            deferred.reject(error);
                        }
                    );
                return deferred.promise;
            }

        }
    ]);
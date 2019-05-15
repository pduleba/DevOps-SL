'use strict';

angular.module('rds').factory('RDSService',
    ['$localStorage', '$http', '$q', 'urls',
        function ($localStorage, $http, $q, urls) {

            var factory = {
                getAll: getAll,
                findAll: findAll,
                findById: findById,
                saveOrder: saveOrder,
                deleteOrder: deleteOrder
            };

            return factory;

            function getAll(){
                console.log('Service.getAll :: From Local storage');
                return $localStorage.orders;
            }

            function findAll() {
                console.log('Service.findAll');
                var deferred = $q.defer();
                $http.get(urls.API_URL + '/rds/findAll')
                    .then(
                        function (response) {
                            console.log('Service.findAll :: Complete');
                            $localStorage.orders = response.data.body;
                            console.log('Service.findAll :: In Local storage');
                            deferred.resolve(response);
                        },
                        function (error) {
                            console.error('Service.findAll :: Error :: ' + error.data.errorMessage);
                            deferred.reject(error);
                        }
                    );
                return deferred.promise;
            }

            function findById(id) {
                console.log('Service.findById');
                var deferred = $q.defer();
                $http.get(urls.API_URL + '/rds/findById/' + id)
                    .then(
                        function (response) {
                            console.log('Service.findById :: Complete');
                            deferred.resolve(response.data.body);
                        },
                        function (error) {
                            console.error('Service.findById :: Error :: ' + error.data.errorMessage);
                            deferred.reject(error);
                        }
                    );
                return deferred.promise;
            }

            function saveOrder(order) {
                console.log('Service.saveOrder');
                var deferred = $q.defer();
                $http.put(urls.API_URL + '/rds/save', order)
                    .then(
                        function (response) {
                            console.log('Service.saveOrder :: Complete');
                            findAll();
                            console.log('Service.saveOrder :: Updating Complete');
                            deferred.resolve(response.data.body);
                        },
                        function (error) {
                            console.error('Service.saveOrder :: Error :: ' + error.data.errorMessage);
                            deferred.reject(error);
                        }
                    );
                return deferred.promise;
            }

            function deleteOrder(id) {
                console.log('Service.deleteOrder');
                var deferred = $q.defer();
                $http.delete(urls.API_URL + '/rds/delete/' + id)
                    .then(
                        function (response) {
                            console.log('Service.deleteOrder :: Complete');
                            findAll();
                            console.log('Service.deleteOrder :: Updating Complete');
                            deferred.resolve(response.data.body);
                        },
                        function (error) {
                            console.error('Service.deleteOrder :: Error :: ' + error.data.errorMessage);
                            deferred.reject(error);
                        }
                    );
                return deferred.promise;
            }

        }
    ]);
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
                console.log('Service.GetAll :: From Local storage');
                return $localStorage.orders;
            }

            function findAll() {
                console.log('Service.FindAll');
                var deferred = $q.defer();
                $http.get(urls.ORDER_API + '/findAll')
                    .then(
                        function (response) {
                            console.log('Service.FindAll :: Complete');
                            $localStorage.orders = response.data.body;
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

            function findById(id) {
                console.log('Service.FindById');
                var deferred = $q.defer();
                $http.get(urls.ORDER_API + '/findById/' + id)
                    .then(
                        function (response) {
                            console.log('Service.FindById :: Complete');
                            deferred.resolve(response.data.body);
                        },
                        function (error) {
                            console.error('Service.FindById :: Error :: ' + error.data.errorMessage);
                            deferred.reject(error);
                        }
                    );
                return deferred.promise;
            }

            function saveOrder(order) {
                console.log('Service.SaveOrder');
                var deferred = $q.defer();
                $http.put(urls.ORDER_API + '/save', order)
                    .then(
                        function (response) {
                            console.log('Service.SaveOrder :: Complete');
                            findAll();
                            console.log('Service.SaveOrder :: Updating Complete');
                            deferred.resolve(response.data.body);
                        },
                        function (error) {
                            console.error('Service.SaveOrder :: Error :: ' + error.data.errorMessage);
                            deferred.reject(error);
                        }
                    );
                return deferred.promise;
            }

            function deleteOrder(id) {
                console.log('Service.DeleteOrder');
                var deferred = $q.defer();
                $http.delete(urls.ORDER_API + '/delete/' + id)
                    .then(
                        function (response) {
                            console.log('Service.DeleteOrder :: Complete');
                            findAll();
                            console.log('Service.DeleteOrder :: Updating Complete');
                            deferred.resolve(response.data.body);
                        },
                        function (error) {
                            console.error('Service.DeleteOrder :: Error :: ' + error.data.errorMessage);
                            deferred.reject(error);
                        }
                    );
                return deferred.promise;
            }

        }
    ]);
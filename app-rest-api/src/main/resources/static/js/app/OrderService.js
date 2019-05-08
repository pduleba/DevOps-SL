'use strict';

angular.module('app').factory('OrderService',
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
                console.log('Get :: From Local storage');
                return $localStorage.orders;
            }

            function findAll() {
                console.log('Find');
                var deferred = $q.defer();
                $http.get(urls.ORDER_API + '/findAll')
                    .then(
                        function (response) {
                            console.log('Find :: Complete');
                            $localStorage.orders = response.data.body;
                            console.log('Find :: In Local storage');
                            deferred.resolve(response);
                        },
                        function (error) {
                            console.error('Find :: Error :: ' + error.data.errorMessage);
                            deferred.reject(error);
                        }
                    );
                return deferred.promise;
            }

            function findById(id) {
                console.log('FindById');
                var deferred = $q.defer();
                $http.get(urls.ORDER_API + '/findById/' + id)
                    .then(
                        function (response) {
                            console.log('FindById :: Complete');
                            deferred.resolve(response.data.body);
                        },
                        function (error) {
                            console.error('FindById :: Error :: ' + error.data.errorMessage);
                            deferred.reject(error);
                        }
                    );
                return deferred.promise;
            }

            function saveOrder(order) {
                console.log('Save');
                var deferred = $q.defer();
                $http.put(urls.ORDER_API + '/save', order)
                    .then(
                        function (response) {
                            console.log('Save :: Complete');
                            findAll();
                            console.log('Save :: Updating Complete');
                            deferred.resolve(response.data.body);
                        },
                        function (error) {
                            console.error('Save :: Error :: ' + error.data.errorMessage);
                            deferred.reject(error);
                        }
                    );
                return deferred.promise;
            }

            function deleteOrder(id) {
                console.log('Delete');
                var deferred = $q.defer();
                $http.delete(urls.ORDER_API + '/deleteById/' + id)
                    .then(
                        function (response) {
                            console.log('Delete :: Complete');
                            findAll();
                            console.log('Delete :: Updating Complete');
                            deferred.resolve(response.data.body);
                        },
                        function (error) {
                            console.error('Delete :: Error :: ' + error.data.errorMessage);
                            deferred.reject(error);
                        }
                    );
                return deferred.promise;
            }

        }
    ]);
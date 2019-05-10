var rds = angular.module('rds',['ui.router','ngStorage','app']);

rds.config(['$stateProvider', '$urlRouterProvider',
    function($stateProvider, $urlRouterProvider) {

        $stateProvider
            .state('rds', {
                url: '/',
                templateUrl: 'partials/view',
                controller:'RDSController',
                controllerAs:'ctrl',
                resolve: {
                    orders: function ($q, RDSService) {
                        console.log('Load all orders');
                        var deferred = $q.defer();
                        RDSService.findAll().then(deferred.resolve, deferred.resolve);
                        return deferred.promise;
                    }
                }
            });
        $urlRouterProvider.otherwise('/');
    }]);


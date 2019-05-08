var app = angular.module('app',['ui.router','ngStorage']);

app.constant('urls', {
    ORDER_API: 'http://localhost:8080/app-rest/api/order'
});

app.config(['$stateProvider', '$urlRouterProvider',
    function($stateProvider, $urlRouterProvider) {

        $stateProvider
            .state('home', {
                url: '/',
                templateUrl: 'partials/list',
                controller:'OrderController',
                controllerAs:'ctrl',
                resolve: {
                    orders: function ($q, OrderService) {
                        console.log('Load all orders');
                        var deferred = $q.defer();
                        OrderService.findAll().then(deferred.resolve, deferred.resolve);
                        return deferred.promise;
                    }
                }
            });
        $urlRouterProvider.otherwise('/');
    }]);


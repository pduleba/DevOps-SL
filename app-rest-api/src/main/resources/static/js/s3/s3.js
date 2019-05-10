var s3 = angular.module('s3',['ui.router','ngStorage','app']);

s3.config(['$stateProvider', '$urlRouterProvider',
    function($stateProvider, $urlRouterProvider) {

        $stateProvider
            .state('s3', {
                url: '/',
                templateUrl: 'partials/view',
                controller:'S3Controller',
                controllerAs:'ctrl',
                resolve: {
                    s3objects: function ($q, S3Service) {
                        console.log('Load all s3objects');
                        var deferred = $q.defer();
                        S3Service.findAll().then(deferred.resolve, deferred.resolve);
                        return deferred.promise;
                    }
                }
            });
        $urlRouterProvider.otherwise('/');
    }]);


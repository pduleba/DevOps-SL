'use strict';

angular.module('s3').
directive('fileInput', ['$parse', function($parse) {
    return {
        restrict: 'A',
        link: function(scope, elm, attrs) {
            elm.bind('change', function() {
                $parse(attrs.fileInput).assign(scope, elm[0].files[0])
                scope.$apply()
            });
        }
    }
}]).
controller('S3Controller',
    ['S3Service', '$scope',  function( S3Service, $scope) {

        var self = this;

        self.submit = submit;
        self.getAll = getAll;
        self.uploadS3Object = uploadS3Object;
        self.deleteS3Object = deleteS3Object;

        self.successMessage = '';
        self.errorMessage = '';

        self.onlyIntegers = /^\d+$/;

        function submit() {
            console.log('Controller.submit');
            uploadS3Object();
            console.log('Controller.submit :: Complete');
        }

        function getAll(){
            console.log('Controller.getAll');
            return S3Service.getAll();
            console.log('Controller.getAll :: Complete');
        }

        function uploadS3Object(){
            console.log('Controller.uploadS3Object');
            self.successMessage='';
            self.errorMessage='';
            var file = $scope.file;
            console.log('Controller.uploadS3Object :: getSignedUrl');
            S3Service.getSignedUrl(file.name)
                .then(
                    function(signedUrl) {
                        console.log('Controller.uploadS3Object :: getSignedUrl :: Complete');
                        S3Service.uploadS3Object(signedUrl, file)
                            .then(
                                function (response){
                                    $scope.s3objectForm.$setPristine();
                                    console.log('Controller.uploadS3Object :: Complete');
                                    self.successMessage='Controller.uploadS3Object :: Complete';
                                },
                                function(error){
                                    console.error('Controller.uploadS3Object :: Error :: ' + error.data);
                                    self.errorMessage='Controller.uploadS3Object :: Error :: ' + error.data;
                                }
                            );
                    },
                    function(error){
                        console.error('Controller.uploadS3Object :: getSignedUrl :: Error :: ' + error.data);
                        self.errorMessage='Controller.uploadS3Object :: getSignedUrl :: Error :: ' + error.data;
                    }
                );
        }

        function deleteS3Object(key){
            console.log('Controller.deleteS3Object');
            self.successMessage='';
            self.errorMessage='';
            S3Service.deleteS3Object(key)
                .then(
                    function(){
                        console.log('Controller.deleteS3Object :: Complete');
                        self.successMessage='Controller.deleteS3Object :: Complete';
                    },
                    function(error){
                        console.error('Controller.deleteS3Object :: Error :: ' + error.data);
                        self.errorMessage='Controller.deleteS3Object :: Error :: ' + error.data;
                    }
                );
        }

    }
    ]);
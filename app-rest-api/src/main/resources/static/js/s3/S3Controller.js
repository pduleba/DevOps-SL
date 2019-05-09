'use strict';

angular.module('s3').controller('S3Controller',
    ['S3Service', '$scope',  function( S3Service, $scope) {

        var self = this;
        self.s3object = {};
        self.s3objects=[];

        self.submit = submit;
        self.reset = reset;
        self.getAll = getAll;
        self.saveS3Object = saveS3Object;
        self.deleteS3Object = deleteS3Object;

        self.successMessage = '';
        self.errorMessage = '';

        self.onlyIntegers = /^\d+$/;

        function submit() {
            console.log('Submit');
            saveS3Object(self.s3object);
            console.log('Submit :: Complete');
        }

        function reset(){
            console.log('Reset');
            self.successMessage='';
            self.errorMessage='';
            self.s3object={};
            $scope.s3objectForm.$setPristine(); //reset Form
            console.log('Reset :: Complete');
        }

        function getAll(){
            console.log('GetAll');
            return S3Service.getAll();
            console.log('GetAll :: Complete');
        }

        function saveS3Object(s3object){
            console.log('Save');
            self.successMessage='';
            self.errorMessage='';
            S3Service.saveS3Object(s3object)
                .then(
                    function (response){
                        console.log('Save :: Complete');
                        self.successMessage='Save :: Complete';
                        $scope.s3objectForm.$setPristine();
                    },
                    function(error){
                        console.error('Save :: Error :: ' + error.data);
                        self.errorMessage='Save :: Error :: ' + error.data;
                    }
                );
        }

        function deleteS3Object(key){
            console.log('Delete');
            self.successMessage='';
            self.errorMessage='';
            S3Service.deleteS3Object(key)
                .then(
                    function(){
                        console.log('Delete :: Complete');
                        self.successMessage='Delete :: Complete';
                    },
                    function(error){
                        console.error('Delete :: Error :: ' + error.data);
                        self.errorMessage='Delete :: Error :: ' + error.data;
                    }
                );
        }

    }
    ]);
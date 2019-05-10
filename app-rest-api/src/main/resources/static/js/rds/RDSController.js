'use strict';

angular.module('rds').controller('RDSController',
    ['RDSService', '$scope',  function( RDSService, $scope) {

        var self = this;
        self.order = {};

        self.submit = submit;
        self.reset = reset;
        self.getAll = getAll;
        self.findById = findById;
        self.saveOrder = saveOrder;
        self.deleteOrder = deleteOrder;
        self.editOrder = editOrder;

        self.successMessage = '';
        self.errorMessage = '';

        self.onlyIntegers = /^\d+$/;

        function submit() {
            console.log('Controller.submit');
            saveOrder(self.order);
            console.log('Controller.submit :: Complete');
        }

        function reset(){
            console.log('Controller.reset');
            self.successMessage='';
            self.errorMessage='';
            self.order={};
            $scope.orderForm.$setPristine(); //reset Form
            console.log('Controller.reset :: Complete');
        }

        function getAll(){
            console.log('Controller.getAll');
            return RDSService.getAll();
            console.log('Controller.getAll :: Complete');
        }

        function findById(id) {
            console.log('Controller.findById');
            self.successMessage='';
            self.errorMessage='';
            RDSService.findById(id).then(
                function (order) {
                    self.order = order;
                    console.log='Controller.findById :: Complete';
                    self.successMessage='Controller.findById :: Complete';
                },
                function (error) {
                        console.error('Controller.findById :: Error :: ' + error.data);
                        self.errorMessage='Controller.findById :: Error :: ' + error.data;
                }
            );
        }

        function saveOrder(order){
            console.log('Controller.saveOrder');
            self.successMessage='';
            self.errorMessage='';
            RDSService.saveOrder(order)
                .then(
                    function (response){
                        console.log('Controller.saveOrder :: Complete');
                        self.successMessage='Controller.saveOrder :: Complete';
                        $scope.orderForm.$setPristine();
                    },
                    function(error){
                        console.error('Controller.saveOrder :: Error :: ' + error.data);
                        self.errorMessage='Controller.saveOrder :: Error :: ' + error.data;
                    }
                );
        }

        function deleteOrder(id){
            console.log('Controller.deleteOrder');
            self.successMessage='';
            self.errorMessage='';
            RDSService.deleteOrder(id)
                .then(
                    function(){
                        console.log('Controller.deleteOrder :: Complete');
                        self.successMessage='Controller.deleteOrder :: Complete';
                    },
                    function(error){
                        console.error('Controller.deleteOrder :: Error :: ' + error.data);
                        self.errorMessage='Controller.deleteOrder :: Error :: ' + error.data;
                    }
                );
        }

        function editOrder(id) {
            console.log('Controller.editOrder');
            self.successMessage='';
            self.errorMessage='';
            RDSService.findById(id).then(
                function (order) {
                    console.log('Controller.editOrder :: Complete');
                    self.order = order;
                },
                function (error) {
                    console.error('Controller.editOrder :: Error :: ' + error.data);
                }
            );
        }

    }
    ]);
'use strict';

angular.module('app').controller('OrderController',
    ['OrderService', '$scope',  function( OrderService, $scope) {

        var self = this;
        self.order = {};
        self.orders=[];

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
            console.log('Submit');
            saveOrder(self.order);
            console.log('Submit :: Complete');
        }

        function reset(){
            console.log('Reset');
            self.successMessage='';
            self.errorMessage='';
            self.order={};
            $scope.orderForm.$setPristine(); //reset Form
            console.log('Reset :: Complete');
        }

        function getAll(){
            console.log('GetAll');
            return OrderService.getAll();
            console.log('GetAll :: Complete');
        }

        function findById(id) {
            console.log('FindById');
            self.successMessage='';
            self.errorMessage='';
            OrderService.findById(id).then(
                function (order) {
                    self.order = order;
                    console.log='FindById :: Complete';
                    self.successMessage='FindById :: Complete';
                },
                function (error) {
                        console.error('FindById :: Error :: ' + error.data);
                        self.errorMessage='FindById :: Error :: ' + error.data;
                }
            );
        }

        function saveOrder(order){
            console.log('SaveOrder');
            self.successMessage='';
            self.errorMessage='';
            OrderService.saveOrder(order)
                .then(
                    function (response){
                        console.log('SaveOrder :: Complete');
                        self.successMessage='SaveOrder :: Complete';
                        $scope.orderForm.$setPristine();
                    },
                    function(error){
                        console.error('SaveOrder :: Error :: ' + error.data);
                        self.errorMessage='SaveOrder :: Error :: ' + error.data;
                    }
                );
        }

        function deleteOrder(id){
            console.log('DeleteOrder');
            self.successMessage='';
            self.errorMessage='';
            OrderService.deleteOrder(id)
                .then(
                    function(){
                        console.log('DeleteOrder :: Complete');
                        self.successMessage='DeleteOrder :: Complete';
                    },
                    function(error){
                        console.error('DeleteOrder :: Error :: ' + error.data);
                        self.errorMessage='DeleteOrder :: Error :: ' + error.data;
                    }
                );
        }

        function editOrder(id) {
            console.log('EditOrder');
            self.successMessage='';
            self.errorMessage='';
            OrderService.findById(id).then(
                function (order) {
                    console.log('EditOrder :: Complete');
                    self.order = order;
                },
                function (error) {
                    console.error('EditOrder :: Error :: ' + error.data);
                }
            );
        }

    }
    ]);
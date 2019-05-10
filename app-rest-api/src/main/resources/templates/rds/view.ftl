<div class="generic-container">
    <div class="panel panel-default">
        <div class="panel-heading">
            <span class="lead">New RDS entry</span>
        </div>
        <div class="panel-body">
            <div class="formcontainer">
                <div class="alert alert-success" role="alert" ng-if="ctrl.successMessage">{{ctrl.successMessage}}</div>
                <div class="alert alert-danger" role="alert" ng-if="ctrl.errorMessage">{{ctrl.errorMessage}}</div>
                <form ng-submit="ctrl.submit()" name="orderForm" class="form-horizontal">
                    <input type="hidden" ng-model="ctrl.order.id"/>
                    <div class="row">
                        <div class="form-group col-md-12">
                            <label class="col-md-2 control-label" for="name">Name</label>
                            <div class="col-md-7">
                                <input type="text" ng-model="ctrl.order.name" id="name"
                                       class="form-control input-sm" placeholder="Enter order name" required
                                       ng-minlength="1"/>
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="form-group col-md-12">
                            <label class="col-md-2 control-label" for="amount">Amount</label>
                            <div class="col-md-7">
                                <input type="text" ng-model="ctrl.order.amount" id="amount"
                                       class="form-control input-sm" placeholder="Enter order Amount." required
                                       ng-minlength="1" ng-pattern="ctrl.onlyIntegers"/>
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="form-actions floatRight">
                            <input type="submit" value="{{!ctrl.order.id ? 'Add' : 'Update'}}"
                                   class="btn btn-primary btn-sm"
                                   ng-disabled="orderForm.$invalid || orderForm.$pristine" />
                            <button type="button" ng-click="ctrl.reset()" class="btn btn-warning btn-sm">Reset Form
                            </button>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
    <div class="panel panel-default">
        <div class="panel-heading">
            <span class="lead">Content of RDS</span>
        </div>
        <div class="panel-body">
            <div class="table-responsive">
                <table class="table table-hover">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>NAME</th>
                            <th>AMOUNT</th>
                            <th width="100"></th>
                            <th width="100"></th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr ng-repeat="o in ctrl.getAll()">
                            <td>{{o.id}}</td>
                            <td>{{o.name}}</td>
                            <td>{{o.amount}}</td>
                            <td>
                                <button type="button" ng-click="ctrl.editOrder(o.id)"
                                        class="btn btn-success custom-width">Edit
                                </button>
                            </td>
                            <td>
                                <button type="button" ng-click="ctrl.deleteOrder(o.id)"
                                        class="btn btn-danger custom-width">Remove
                                </button>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>
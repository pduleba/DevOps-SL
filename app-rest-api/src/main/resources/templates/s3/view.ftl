<div class="generic-container">
    <div class="panel panel-default">
        <div class="panel-heading">
            <span class="lead">S3 Object</span>
        </div>
        <div class="panel-body">
            <div class="formcontainer">
                <div class="alert alert-success" role="alert" ng-if="ctrl.successMessage">{{ctrl.successMessage}}</div>
                <div class="alert alert-danger" role="alert" ng-if="ctrl.errorMessage">{{ctrl.errorMessage}}</div>
                <form ng-submit="ctrl.submit()" name="s3objectForm" class="form-horizontal">

                    <div class="row">
                        <div class="form-group col-md-12">
                            <label class="col-md-2 control-label" for="s">Select File</label>
                            <div class="col-md-7">
                                <input type="file" ng-model="ctrl.s3object.file" id="file"
                                       class="form-control input-sm" placeholder="Select file" required
                                       ng-minlength="1"/>
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="form-actions floatRight">
                            <input type="submit" value="Add/Update"
                                   class="btn btn-primary btn-sm"
                                   ng-disabled="s3objectForm.$invalid || s3objectForm.$pristine" />
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
            <span class="lead">List of S3 Objects</span>
        </div>
        <div class="panel-body">
            <div class="table-responsive">
                <table class="table table-hover">
                    <thead>
                        <tr>
                            <th>FILE NAME</th>
                            <th>LAST MODIFIED</th>
                            <th>SIZE</th>
                            <th width="100"></th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr ng-repeat="s3object in ctrl.getAll()">
                            <td>{{s3object.key}}</td>
                            <td>{{s3object.lastModified}}</td>
                            <td>{{s3object.size}}</td>
                            <td>
                                <button type="button" ng-click="ctrl.deleteS3Object(s3object.key)"
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
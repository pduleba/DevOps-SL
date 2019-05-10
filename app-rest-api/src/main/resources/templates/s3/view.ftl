<div class="generic-container">
    <div class="panel panel-default">
        <div class="panel-heading">
            <span class="lead">New S3 entry</span>
        </div>
        <div class="panel-body">
            <div class="formcontainer">
                <div class="alert alert-success" role="alert" ng-if="ctrl.successMessage">{{ctrl.successMessage}}</div>
                <div class="alert alert-danger" role="alert" ng-if="ctrl.errorMessage">{{ctrl.errorMessage}}</div>
                <form ng-submit="ctrl.submit()" name="s3objectForm" class="form-horizontal">

                    <div class="row">
                        <div class="form-group col-md-12">
                            <label class="col-md-2 control-label" for="file">Select File</label>
                            <div class="col-md-7">
                                <!--<input id="inp_file" type="file" file-input="file" multiple="multiple" />-->
                                <input id="file" type="file" file-input="file"
                                       class="form-control input-sm" placeholder="Select file" required />
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="form-actions floatRight">
                            <input type="submit" value="Add/Update"
                                   class="btn btn-primary btn-sm" />
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
    <div class="panel panel-default">
        <div class="panel-heading">
            <span class="lead">Content of S3</span>
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
                            <td>{{s3object.size + ' B'}}</td>
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
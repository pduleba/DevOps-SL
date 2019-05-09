<!DOCTYPE html>

<html lang="en" ng-app="s3">
    <head>
        <title>${title}</title>
        <link href="css/bootstrap.css" rel="stylesheet"/>
        <link href="css/app.css" rel="stylesheet"/>
    </head>
    <body>
        <div ui-view></div>
        <script src="js/lib/angular.min.js"></script>
        <script src="js/lib/angular-ui-router.min.js"></script>
        <script src="js/lib/localforage.min.js"></script>
        <script src="js/lib/ngStorage.min.js"></script>
        <script src="js/s3/s3.js"></script>
        <script src="js/s3/S3Service.js"></script>
        <script src="js/s3/S3Controller.js"></script>
    </body>
</html>
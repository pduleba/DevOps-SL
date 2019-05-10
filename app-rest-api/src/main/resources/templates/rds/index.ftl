<!DOCTYPE html>

<html lang="en" ng-app="rds">
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
        <script src="js/app.js"></script>
        <script src="js/rds/rds.js"></script>
        <script src="js/rds/RDSService.js"></script>
        <script src="js/rds/RDSController.js"></script>
    </body>
</html>
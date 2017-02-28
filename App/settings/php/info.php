<!DOCTYPE html>
<html lang="en" ng-app="eApp" >
<head>
<title> Enterprise Resource Management</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- Latest compiled and minified CSS -->
<script src="./javascripts/jquery-1.12.2.js" ></script>
<link rel="stylesheet" href="./bootstrap/css/bootstrap.min.css" integrity="sha384-1q8mTJOASx8j1Au+a5WDVnPi2lkFfwwEAa8hDDdjZlpLegxhjVME1fgjWPGmkzs7" crossorigin="anonymous">
<link rel="stylesheet" href="./bootstrap/css/bootstrap-theme.min.css" integrity="sha384-fLW2N01lMqjakBkx3l/M9EahuwpSfeNvV63J5ezn3uZzapT0u7EYsXMjQV+0En5r" crossorigin="anonymous">
<script src="./bootstrap/js/bootstrap.min.js" integrity="sha384-0mSbJDEHialfmuBBQP6A4Qrprq5OVfW37PRR3j5ELqxss1yVqOtnepnHVP9aJ7xS" crossorigin="anonymous"></script>
<script src="./javascripts/angular.js" ></script>
<script src="./javascripts/angular-route.js" ></script>
<script src="./javascripts/app.js" ></script>
<script src="./javascripts/route/route.js" ></script>
<script src="./javascripts/services/services.js" ></script>
<script src="./javascripts/controllers/controllers.js" ></script>

</head>
<body>
<h4> Erp Application Dashboard </h4>
<div ng-include ="'navigations.html'" ></div>

<div class="container">
<div ng-view >

</div>
</div>
</body>
</html>

<?php
phpinfo();
?>
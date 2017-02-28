var login = angular.module("login",[]);
login.controller('loginController',['$scope', '$http', function( $scope, $http){
	$scope.user = {email: "", password: ""};	
	$scope.signIn = function() {
		$http.post("settings/php/login.php", $scope.user ).success(function(data){	
			$scope.welcome = {};
			$scope.welcome = data;	
			console.log($scope.welcome.islogin);
			if($scope.welcome.islogin){
				document.location = "application/index.html";
			}
		})				
	}    	
}]);


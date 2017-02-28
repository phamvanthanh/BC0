var login = angular.module("login",[]);
login.controller('loginController',['$scope', '$http', function( $scope, $http){
	$scope.user = {email: "", password: ""};	
	$scope.signIn = function() {
		$http.post("../php/login.php", $scope.user ).success(function(data){	
			$scope.welcome = {};
			$scope.welcome = data;				
			console.log($scope.welcome);
			//document.location = "./php/login.php";
		})				
	}    	
}]);


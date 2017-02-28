eApp.run(['$rootScope', '$http', function($rootScope, $http){	
    $http.get('php/session.php').success(function (data){$rootScope.welcome = data;
		if($rootScope.welcome.islogin){
			$http.get('php/fetchElement.php').success(function (data){$rootScope.elements = data; console.log(data);}),
			$http.get('php/fetchTransaction.php').success(function (data){$rootScope.trantractions = data; console.log(data);}),
			$http.get('php/fetchNode.php').success(function (data){$rootScope.nodes = data; console.log(data);}),
			$http.get('php/fetchTransactionSetup.php').success(function (data){$rootScope.transactionSetups = data; console.log(data);}),
			$http.get('php/fetchNodeRestriction.php').success(function (data){$rootScope.nodeRestrictions = data; console.log($rootScope.nodeRestrictions);}),
			$http.get('php/fetchUser.php').success(function (data){$rootScope.users = data; console.log(data);});
			$http.get('php/fetchUserAssignment.php').success(function (data){$rootScope.userAssignments = data; console.log(data);});
		}
		else {
			document.location = "/App/login.html";
		}
		
	});	
	
}]);

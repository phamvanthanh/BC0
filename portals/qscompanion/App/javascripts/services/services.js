eApp.run(['$rootScope', '$http', function($rootScope, $http){	
    $http.get('./php/session.php').success(function (data){$rootScope.welcome = data;
		if($rootScope.welcome.islogin){
			$http.get('./php/fetchElement.php').success(function (data){$rootScope.elements = data;}),
			$http.get('./php/fetchTransaction.php').success(function (data){$rootScope.trantractions = data;}),
			$http.get('./php/fetchNode.php').success(function (data){$rootScope.nodes = data;}),
			$http.get('./php/fetchTransactionSetup.php').success(function (data){$rootScope.transactionSetups = data;}),
			$http.get('./php/fetchNodeRestriction.php').success(function (data){$rootScope.nodeRestrictions = data;}),
			$http.get('./php/fetchUser.php').success(function (data){$rootScope.users = data;});
			$http.get('./php/fetchUserAssignment.php').success(function (data){$rootScope.userAssignments = data;});
		}
		else {
			document.location = "./login.html";
		}
		
	});	
	
}]);

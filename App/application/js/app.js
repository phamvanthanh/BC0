var myApp = angular.module('myApp', ['ui.router', 'ui.bootstrap']);
myApp.run(function($rootScope, $http){  	
	$http.get('../settings/php/session.php').success(function (data){$rootScope.welcome = data;
		if($rootScope.welcome.islogin){
			$http.get('../settings/php/fetchElement.php').success(function (data){$rootScope.elements = data;}),
			$http.get('../settings/php/fetchTransaction.php').success(function (data){$rootScope.transactions = data;}),
			$http.get('../settings/php/fetchNode.php').success(function (data){$rootScope.nodes = data;}),
			$http.get('../settings/php/fetchTransactionSetup.php').success(function (data){$rootScope.transactionSetups = data;}),
			$http.get('../settings/php/fetchNodeRestriction.php').success(function (data){$rootScope.nodeRestrictions = data;}),
			$http.get('../settings/php/fetchUser.php').success(function (data){$rootScope.users = data;});
			$http.get('../settings/php/fetchUserAssignment.php').success(function (data){$rootScope.userAssignments = data;});
					
		}
		else {
			document.location = "/login.html";
		}
		
	});	
	
});

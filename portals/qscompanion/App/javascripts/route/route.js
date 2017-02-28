
eApp.config(function($routeProvider){
	$routeProvider.when('/Users', {
		templateUrl: '/settings/users/users.html'
	})
	.when('/Elements',{
		templateUrl: '/settings/elements/elements.html'
	})
	.when('/Transactions', {
		templateUrl: '/settings/transactions/transactions.html'
	})
	.when('/Nodes', {
		templateUrl: '/settings/nodes/nodes.html'
	})
	.when('/TransactionSetup', {
		templateUrl: '/settings/transactions/transactionsetups.html'
	})
	.when('/NodeRestrictions', {
		templateUrl: '/settings/nodes/noderestrictions.html'
	})
	.when('/UserAssignments', {
		templateUrl: '/settings/users/userasignement.html'
	})	
	.otherwise({redirectTo: '/'});
	
});

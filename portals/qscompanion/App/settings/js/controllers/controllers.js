eApp.controller('loginController',['$scope', '$http', function( $scope, $http){
	$scope.user = {email: "", password: ""};	
	
	$scope.signIn = function() {
		$http.post("/App/settings/php/login.php", $scope.user ).success(function(data){	
			$scope.welcome = {};
			$scope.welcome = data;
			
		})				
	}    	
}]);

/* 01 ->Element Section */
eApp.controller('ElementController',['$scope', '$rootScope', '$http', function( $scope, $rootScope, $http){
	if($rootScope.elements){
		$scope.elements =  $rootScope.elements ;
	}
	else {
		$scope.elements = [{code: "#", name: "Data is not loaded"}];
	}	
	$scope.Enum = $scope.elements.length;
	$scope.element = {};
	$scope.editE = function(x){
		$scope.element = $scope.elements[x];				
	};
	
	$scope.addE = function(){		
		$http.post("/App/settings/php/insertElement.php", $scope.element)
		.success(function(data, status, header, config){			
			
			$scope.response = data;
			console.log(data);
		    //document.location = "./php/insertElement.php";
			$http.get('/App/settings/php/fetchElement.php').success(function (data){
				$scope.elements = data;
				$scope.element = {};	
			})
			
		}); 
	};
	$scope.deleteE = function(){		
		$http.post("/App/settings/php/deleteElement.php", {'code': $scope.element.code})
		.success(function(data, status, header, config){			
			$scope.element = {};
			$http.get('/App/settings/php/fetchElement.php').success(function (data){
				$scope.elements = data;
			})
		}); 
	};    	
}]);
/* 02 -> Transaction Section */
eApp.controller('TransactionController',[ '$scope', '$rootScope', '$http', function( $scope, $rootScope, $http){
	
	if(!$scope.transactions){
		$scope.transactions =  $rootScope.trantractions;
	}	

	$scope.num = $scope.transactions.length;
	$scope.transaction = {};
	$scope.edit = function(x){
		$scope.transaction = $scope.transactions[x];		
	};
	
	$scope.save = function(){		
		$http.post("/App/settings/php/insertTransaction.php", $scope.transaction)
		.success(function(data, status, header, config){
			console.log($scope.transaction);
			$http.get('/App/settings/php/fetchTransaction.php').success(function (data){
				$scope.transactions = data;
				$scope.transaction = {};	
			})
			
		}); 
	};
	$scope.del = function(){		
		$http.post("/App/settings/php/deleteTransaction.php", {'code': $scope.transaction.code})
		.success(function(data, status, header, config){			
			$scope.transaction = {};
			$http.get('/App/settings/php/fetchTransaction.php').success(function (data){
				$scope.transactions = data;
			})
		}); 
	};    	
}]);
/* 04 -> Node section */
eApp.controller('NodeController',[ '$scope', '$rootScope', '$http', function( $scope, $rootScope, $http){
	$scope.Nnum = $scope.nodes.length;
	if(!$scope.nodes){
		$scope.nodes =  $rootScope.nodes;
	}	
	$scope.node = {};
	$scope.editN = function(x){
		$scope.node = $scope.nodes[x];
				
	};
	
	$scope.addN = function(){		
		$http.post("/App/settings/php/insertNode.php", $scope.node)
		.success(function(data, status, header, config){			
			console.log($scope.node);			
			$http.get('/App/settings/php/fetchNode.php').success(function (data){
				$scope.nodes = data;
				$scope.node = {};	
			})
			
		}); 
	};
	$scope.deleteN = function(){		
		$http.post("/App/settings/php/deleteNode.php", {'code': $scope.node.code})
		.success(function(data, status, header, config){			
			$scope.node = {};
			$http.get('/App/settings/php/fetchNode.php').success(function (data){
				$scope.nodes = data;
			})
		}); 
	};    	
}]);
/* 05 -> Transaction Setup Section */
eApp.controller('TransactionSetupController',[ '$scope', '$rootScope', '$http', function( $scope, $rootScope, $http){
	$scope.nodes =  $rootScope.nodes;
	$scope.nodeRestrictions =  $rootScope.nodeRestrictions;
	$scope.transactions =  $rootScope.transactions;
	console.log($rootScope.transactionSetups);
	$scope.transactionSetups = $rootScope.transactionSetups;
	$scope.num = $scope.transactionSetups.length;
	$scope.transactionSetup = {};
	
	$scope.save = function(){		
		$http.post("/App/settings/php/insertTransactionSetup.php", $scope.transactionSetup)
		.success(function(data, status, header, config){			
						
			$http.get('/App/settings/php/fetchTransactionSetup.php').success(function (data){
				$scope.transactionSetups = data;
				$scope.transactionSetup = {};	
			})			
		}); 
	};
	$scope.edit = function(x){
		$scope.transactionSetup.transaction = $scope.transactionSetups[x].transaction;
		$scope.transactionSetup.node = $scope.transactionSetups[x].node;
		$scope.transactionSetup.restriction = $scope.transactionSetups[x].restriction;
		$scope.transactionSetup.parentNode = $scope.transactionSetups[x].parentNode;		
	};
	
	$scope.del = function(){		
		$http.post("/App/settings/php/deletetransactionSetup.php", {'transaction': $scope.transactionSetup.transaction})
		.success(function(data, status, header, config){			
			$scope.transactionSetups = {};
			$http.get('/App/settings/php/fetchtransactionSetup.php').success(function (data){
				$scope.transactionSetups = data;
			})
		}); 
	};    	
}]);
/* 06 -> Node Restriction Section */
eApp.controller('NodeRestrictionController',[ '$scope', '$rootScope', '$http', function( $scope, $rootScope, $http){
	
	$scope.nodeRestrictions = $rootScope.nodeRestrictions;
	$scope.num = $scope.nodeRestrictions.length;
	$scope.nodeRestriction = {};
	$scope.save = function(){		
		$http.post("/App/settings/php/insertNodeRestriction.php", $scope.nodeRestriction)
		.success(function(data, status, header, config){			
						
			$http.get('/App/settings/php/fetchNodeRestriction.php').success(function (data){
				$scope.nodeRestrictions = data;
				$scope.nodeRestriction = {};	
			})			
		}); 
	};
	$scope.edit = function(x){
		$scope.nodeRestriction = $scope.nodeRestrictions[x];
					
	};
	
	$scope.del = function(){		
		$http.post("/App/settings/php/deletenodeRestriction.php", {'code': $scope.nodeRestriction.code})
		.success(function(data, status, header, config){			
			$scope.nodeRestrictions = {};
			$http.get('/App/settings/php/fetchnodeRestriction.php').success(function (data){
				$scope.nodeRestrictions = data;
			})
		}); 
	};    	
}]);
/* 07 -> User Section */
eApp.controller('UserController',['$scope', '$rootScope', '$http', function( $scope, $rootScope, $http){

	$scope.users = $rootScope.users;	
	$scope.num = $scope.users.length;
	
	$scope.user = {};
	$scope.save = function(){		
		$http.post("/App/settings/php/insertUser.php", $scope.user)
		.success(function(data, status, header, config){			
			
			$http.get('/App/settings/php/fetchUser.php').success(function (data){
				$scope.users = data;
				$scope.user = {};	
			})			
		}); 
	};
	$scope.edit = function(x){
		$scope.user =  $scope.users[x];
	};
	
	$scope.del = function(){		
		$http.post("/App/settings/php/deleteUser.php", {'uid': $scope.user.uid})
		.success(function(data, status, header, config){			
			$scope.user = {};
			$http.get('/App/settings/php/fetchUser.php').success(function (data){
				$scope.users = data;
			})
		}); 
	};    	
}]);
/* 08 User Assignment Section */
eApp.controller('UserAssignmentController',['$scope', '$rootScope', '$http', function( $scope, $rootScope, $http){

	$scope.userAssignments = $rootScope.userAssignments;	
	$scope.num = $scope.userAssignments.length;
	
	$scope.users = $rootScope.users;
	$scope.nodes =  $rootScope.nodes;
	
	$scope.userAssignment = {};
	$scope.save = function(){		
		$http.post("/App/settings/php/insertUserAssignment.php", $scope.userAssignment)
		.success(function(data, status, header, config){			
			
			$http.get('/App/settings/php/fetchUserAssignment.php').success(function (data){
				$scope.userAssignments = data;
				$scope.userAssignment = {};	
			})			
		}); 
	};
	$scope.edit = function(x){
		$scope.userAssignment =  $scope.userAssignments[x];
	};
	
	$scope.del = function(){		
		$http.post("/App/settings/php/deleteUserAssignment.php", {'uid': $scope.userAssignment.uid})
		.success(function(data, status, header, config){			
			$scope.userAssignment = {};
			$http.get('/App/settings/php/fetchUserAssignment.php').success(function (data){
				$scope.userAssignments = data;
			})
		}); 
	};    	
}]);

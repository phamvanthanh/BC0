angular.module("myApp", []);

eApp.controller('UiController',['$scope', '$rootScope', '$http', function( $scope, $rootScope, $http){
	function findItem(array, value, field){
		for (var i = 0; i <= array.length; i++){
			for (key in array[i]){
				if(array[i][key] == value){
					return array[i][field];
				}
			}
		}
	}
	function findList(tranSetup, tran, node, tCode, parentNode, restriction ){
		var list = [];
		for (var i = 0; i < tranSetup.length; i++){
			for (key in tranSetup[i]){
				if(tranSetup[i][key] == node){					
					list.push({TCode: tranSetup[i][tCode], TName: findItem($scope.trantractions, tranSetup[i][tCode], 'name' ), Stream: findItem($scope.trantractions, tranSetup[i][tCode], 'stream' ), PNode: findItem($scope.nodes, tranSetup[i][parentNode], "name"), R: tranSetup[i][restriction]});
				}
			}
		}
		return list;
	}
				
	$scope.elements = $rootScope.elements;
	$scope.trantractions = $rootScope.trantractions;
	$scope.nodes = $rootScope.nodes;
	$scope.transactionSetups = $rootScope.transactionSetups;
	$scope.nodeRestrictions = $rootScope.nodeRestrictions;
	$scope.users = $rootScope.users;
	$scope.userAssignments = $rootScope.userAssignments;
	
	var uid = findItem($scope.users, $rootScope.welcome.msg, 'uid');
	$scope.node = findItem($scope.userAssignments, uid, 'node');
	
	$scope.trans = findList($scope.transactionSetups, $scope.transactions, $scope.node, 'transaction', 'parentNode', 'restriction');
	console.log(uid);
	console.log($scope.node); 
	console.log($scope.trans);
	
	
}]);
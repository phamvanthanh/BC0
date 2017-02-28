myApp.config(function($stateProvider, $urlRouterProvider){
	$stateProvider.state('pm', {
		views:{
			'leftPane': {				
				//url: 'pm',
				templateUrl: '../application/templates/sections/ccm/ccmLeftPane.html',
				controller: function($scope, master, $rootScope){	
					$scope.trans = master.trans;
					
					$scope.tranferInfo = function(y){
						$rootScope.thisTransInfo = y;						
					};														
				}	
			},
			'content': {
				//url: 'pm',
				templateUrl: '../application/templates/sections/ccm/ccmContent.html',
				controller: function($scope){
					
				}
			}		
				
		}
		
	}).
	state('pm.01',{		
				//url: '01',
				templateUrl: '../application/templates/sections/ccm/transactions/01.html',
				controller: function($timeout, $scope, $rootScope, master, $http){
					$scope.units = ['m', 'm2','m3', 'kg', 'ton', 'lot', 'ea', 'rol'];
					$scope.items = [];					
					$scope.item = undefined;					
					
					$scope.add = function(){
						$scope.item.code = $("input[name='code']").val();
						console.log($scope.item);						
						$scope.items.push($scope.item);
						$scope.item = undefined;
						$("input[name='code']").val("");
															
					}
					console.log($rootScope.thisTransInfo);					
					console.log(master.user);
					$scope.save = function() {						
						$http({
							method: "POST",
							url: "../application/php/transactions/01isave.php",
							data: {'thisTransInfo' : $rootScope.thisTransInfo, 'user': master.user, 'items': $scope.items, state: 0 }
						}).success(function (data){
							console.log(data); 
						})
					};
					
					
				}
			
		
	}).
		state('pm.02',{		
				//url: '01',
				templateUrl: '../application/templates/sections/ccm/transactions/02.html',
				controller: function($timeout, $scope, $rootScope, master, $http){
					$scope.units = ['m', 'm2','m3', 'kg', 'ton', 'lot', 'ea', 'rol'];
					$scope.items = [];					
					$scope.item = undefined;					
					
					$scope.add = function(){
						$scope.item.code = $("input[name='code']").val();
						console.log($scope.item);						
						$scope.items.push($scope.item);
						$scope.item = undefined;
						$("input[name='code']").val("");
															
					}
					console.log($rootScope.thisTransInfo);					
					console.log(master.user);
					$scope.save = function() {						
						$http({
							method: "POST",
							url: "../application/php/transactions/01isave.php",
							data: {'thisTransInfo' : $rootScope.thisTransInfo, 'user': master.user, 'items': $scope.items, state: 0 }
						}).success(function (data){
							console.log(data); 
						})
					};
					
					
				}
			
		
	});
	
	
	
});

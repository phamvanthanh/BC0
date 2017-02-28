myApp.factory('funcs', function() {
        return {						
				findItem : function (findArr, returnField, findField, findKey){ // findArray (array), findField (string), findKey (string)
					var list = [];
					for (var i = 0; i < findArr.length; i++){
							if(findArr[i][findField] == findKey){
								list.push(findArr[i][returnField]);
							}
					}		
					return list;
				},
				
				findList: function (tranSetupArr, tranArr, nodeArr, node){ // node is find Key
					var list = [];
					for (var i = 0; i < tranSetupArr.length; i++){
						for (key in tranSetupArr[i]){
							if(tranSetupArr[i][key] == node){					
								list.push({TCode: tranSetupArr[i]['tCode'], TName: this.findItem(tranArr, 'name', 'code', tranSetupArr[i]['tCode'] )[0], Stream: this.findItem(tranArr, 'stream', 'code', tranSetupArr[i]['tCode'] )[0], PNode:  tranSetupArr[i]['parentNode'], NR: tranSetupArr[i]['restriction'], TR: this.findItem(tranArr, 'restriction', 'code', tranSetupArr[i]['tCode'] )[0] });
							}
						}
					}
					return list;
				}
			
			
        };
});
myApp.factory('master', function($rootScope, funcs) {
	
	var uid = funcs.findItem($rootScope.users, 'uid', 'email', $rootScope.welcome.msg);
	var node = funcs.findItem($rootScope.userAssignments, 'node', 'uid', uid);
	return {
		trans : funcs.findList($rootScope.transactionSetups, $rootScope.transactions, $rootScope.transactions, node[0]),
		user: {uid: uid[0], node: node[0]}
	};
});	
	      



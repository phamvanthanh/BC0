myApp.directive('autoName', function($timeout, $rootScope) {
    		
	return {
		restrict: 'A',		
		link: function(scope, elem, attr, ctrl) {
				elem.autocomplete({
					source: $rootScope.elements,
					select: function (event, ui) {						
						$("input[name='code']").val(ui.item.code);
						//$("input[name='code']").prop('disabled', true);						
						$timeout(function () {
                            elem.trigger("input");												
							 
                       }, 0); 						
					}
			});	
				
		}
	};	
});


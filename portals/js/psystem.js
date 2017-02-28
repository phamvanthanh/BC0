$(document).ready(function(){   
    // Variable to hold request
    var request, project, button, query, data, file, div, dataRecord;
    $(document.body).on('click', 'input[name*="add"], input[name*="remove"]', function(event){ 
    
    //console.log(issend);
    // Prevent default posting of form - put here to work in case of errors
    event.preventDefault();
    button = $(event.target); 

    // Abort any pending request
    if (request) {
        request.abort();
    }
   
   // Project Id and the Employee Id is in session
   query = $(this).attr('name');
   data = $(this).parents('form').find('input[name="data"]').val();
   console.log(data);
   switch(data)
   {
       case 'pwbs':
            var callback = function(){};    
            if(query == 'add')
                dataRecord = {records: pwbsSelects, data: data, query: query };
               
            if(query == 'remove')
                dataRecord = {records: pWbsDeselects, data: data, query: query };
            file = 'pwbs';
            div = '#form';
            break;
      case 'pwbs_employee':
             var callback = function() {
                    load("#list", 'employee_pwbs_list');
                   
                };

             if(query == 'add')
                dataRecord = {records: pwbsSelects, data: data, query: query };
               
            if(query == 'remove')
                dataRecord = {records: pWbsDeselects, data: data, query: query };
                file = 'employee_pwbs_list';
                div = '#list';
            break;

    default:
            break;



   }
   console.log(dataRecord);
    
    {          
        // Fire off the request to /form.php
        request = $.ajax({
            url: "../process/_data-queries.php",
            type: "post",
            data: dataRecord,
            success: function( response, status, xhttp) {
                load(div, file, function(){
                    callback();
                });
                pwbsSelects = [];
                pWbsDeselects = [];
                console.log(response);
            }
        });
         request.done(function (response, textStatus, jqXHR){      
		
        });
        
         request.fail(function (jqXHR, textStatus, errorThrown){
        
            console.error(
                "The following error occurred: "+
                textStatus, errorThrown
            );
        });


        request.always(function () {
       
        });    }
});
/**********************************END OF AJAX FORM SUBMISSION********************************************/
$(document.body).on('change', 'select[name*="project"], select[name*="project_employee"]', function(event){ 
        var project, form, name, div, file, data, dash, project_employee;
       // form = $(this).parentsUntil('#sform','form');
      
        dash = getParameterByName('divdash');
       
        name = $(this).attr('name');      
        switch(dash)
        {
            case 'pwbs_display': 
                
                var callback = function(){};       
                div = '#divform';
                file = 'pwbs_form';
                project = $(this).val();
                data = {data: 'pwbs', query: 'project', project: project};
                break;

             case 'qto_display': 
                if(name == 'project')
                {
                    var callback = function() {
                        load("#pwbs-emp", 'pwbs_emp', function(){
                        load("#list", 'qto_table');
                    });};
                   
                    div = '#list';
                    file = 'qto_table';
                    project = $(this).val();
                    data = {data: 'qto', query: 'project', project: project};
                  
                }
                if(name == 'project_employee')
                {
                    var callback = function(){};
                    div = '#list';
                    file = 'qto_table';
                    project = $('select[name*="project"]').val();
                    project_employee = $(this).val();
                    data = {data: 'qto', query: 'project_employee', project: project, project_employee: project_employee};
                    console.log(data);
                }
                break;
               
            case 'project_assignment_display':
                            
                if(name == 'project')
                {
                    var callback = function() {
                        load("#divpwbs-emp-form", 'pwbs_emp', function(){
                        load("#divlist", 'employee_pwbs_list');
                    });};
                   
                    div = '#divform';
                    file = 'pwbs_half_form';
                    project = $(this).val();
                    data = {data: 'pwbs', query: 'project', project: project};
                  
                }
                if(name == 'project_employee')
                {
                    var callback = function(){};
                    div = '#divlist';
                    file = 'employee_pwbs_list';
                    project = $('select[name*="project"]').val();
                    project_employee = $(this).val();
                    data = {data: 'pwbs', query: 'project_employee', project: project, project_employee: project_employee};
                    
                }
                break;
            default:
                break;
        }
      
        
        request = $.ajax({
            url: "../process/_data-queries.php",
            type: "post",
            data: data,
            success: function( data, status, xhttp) {
                load(div, file, function(){
                    callback();
                });                           

            }
        });
        request.done(function (response, textStatus, jqXHR){      
        
        });
        
        request.fail(function (jqXHR, textStatus, errorThrown){
        
            console.error(
                "The following error occurred: "+
                textStatus, errorThrown
            );
        });


        request.always(function () {
    
        });    
    
    });
});










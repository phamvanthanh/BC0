/*********************URL PARAMETERS*************************/

// Global variables
// Send form submit
var edit = false; // turn true every time click edit, to determine form, fields validation
Array.prototype.diff = function(a) { // Find different of one dimesion array
    return this.filter(function(i) {return a.indexOf(i) < 0;});
};

function diff(A, B) {
    return A.filter(function (a) {
        return B.indexOf(a) == -1;
    });
}

function getParameterByName(name, url) { // Get a URL parameter from URL 
    if (!url) {
      url = window.location.href;    
    }
    name = name.replace(/[\[\]]/g, "\\$&");
    var regex = new RegExp("[#-&]" + name + "(=([^&#]*)|&|#|$)");
   
    results = regex.exec(url);
        
    if (!results) return null;
    if (!results[2]) return '';
    return decodeURIComponent(results[2].replace(/\+/g, " "));
}

function getParametersInArray(){ // Get URL parameters in array for loading files to divs with parameter's array
     var i = 0, loc, paramArr = new Array(), z, temp;
     loc = window.location.href;
     if(loc.indexOf('#') >= 0 || loc.indexOf('?') >= 0)
     {
        loc = loc.indexOf('#') >= 0? loc.slice(loc.indexOf('#')+1) : loc.slice(loc.indexOf('?')+1);
        loc = JSON.parse('{"' + decodeURI(loc).replace(/"/g, '\\"').replace(/&/g, '","').replace(/=/g,'":"') + '"}');  // parse uri parameters to javascript object
     
        for( var prop in loc)
        {
 
            if((prop.toString()).indexOf("div") < 0)
                delete loc[prop];          
            
        }     
        if(loc != null)
        {
            for( var prop in loc)
            {
                z = new Array(prop, loc[prop]); 
                paramArr.push(z);

            }
        
           
        }   
    
    
    }
 
     return paramArr;
}
function parseParameterstoArray(loc){ // Parse URL parameters string to array
    var i = 0, loc, paramArr = new Array(), z;     
    if(loc.indexOf('#') >= 0 || loc.indexOf('?') >= 0)
     {
        loc = loc.indexOf('#') >= 0? loc.slice(loc.indexOf('#')+1) : loc.slice(loc.indexOf('?')+1);
     }
     
    if(loc.indexOf('&')==0)
        loc = loc.slice(1);

    loc = JSON.parse('{"' + decodeURI(loc).replace(/"/g, '\\"').replace(/&/g, '","').replace(/=/g,'":"') + '"}');  // parse uri parameters to javascript object
    
    for( var prop in loc)
    {

        if((prop.toString()).indexOf("div") < 0)
            delete loc[prop];          
        
    }     
    if(loc != null)
    {
        for( var prop in loc)
        {
            z = new Array(prop, loc[prop]); 
            paramArr.push(z);

        }    
        
    }  
   
    return paramArr;
}
/////////////////////*DISPLAY ARRANGE****************//
function displayForm(){    
    $('#divform').removeClass('hidden');
    $('#divlist').addClass('col-sm-7');       
    
}

/*********************LOAD FILE FUNCTION*************************/
function load(div, file, callback){ // Load specific file to specific div, loaded file must be placed in includes folders
     var loc= "../includes/" + file +".php";           
    if(div == '#divform')
        displayForm();
    if(div.indexOf("div") > 0)
    {
  
        $(div).load(loc, function(){
            if (callback && typeof(callback) === "function") {
                callback();
            }
        }) 
    }
    else
        return;
             
}
function loadFile(div, file, callback){ // Load specific file to specific div, loaded file must be placed in includes folders
       
     $(div).load(file, function(){
           if (callback && typeof(callback) === "function") {
              callback();
         }
     }) 
             
}

loadAll = (function (arr){  // Load all files to divs with parameter's array inputed.   
    var i = 0;    
   
    return function(){
     
        var paramArr = (arr && typeof(arr) == 'object')? arr: getParametersInArray(); 
                  
        if(i < paramArr.length)
        
            load("#"+paramArr[i][0], paramArr[i][1], function(){      
                 
                i++; 
                loadAll(paramArr);  
                         
                               
            }); 
        else       
            i = 0;            
    }
    
})();

function editMode(el)
{
    var emode = getParameterByName('emode'),  i; 
    if(emode == 'true')
    {
        var element = document.getElementById(el);
        var list = $(element).find('span.index');
         
        for( i=0; i < list.length; i++)
        {
            
            $(list[i]).after('<a class="edit-wbs"> ...</a>');
        }
        
    }
}

function mapId(item){ 
    return item[0];
}
function mapName(item){
    return item[1].toUpperCase();           
}
function mapEmail(item){
    return item[3].toUpperCase();           
}
function findInputByName(form,fname){
   return  $(form).find('input[name*='+fname+']'); 
}
function findSelectByName(form, fname){
   return  $(form).find('select[name*='+fname+']'); 
}

 /*********************SEARCH RECORDS FUNCTION *************************/
// Live table search 
function tableSearch(el, targetTable) {
  var input, filter, table, tr, td,  i, j ;    
  filter = $(el).val().toUpperCase();  
  table = document.getElementById(targetTable);  
  tr = table.getElementsByTagName("tr");  
  col = (table.getElementsByTagName("thead")[0].getElementsByTagName("tr")[0].getElementsByTagName("th")).length;
  
  for (i = 0; i < tr.length; i++) {
    var string = "", t;
    for (j = 0; j < col; j++) {
        t = tr[i].getElementsByTagName("td")[j];
        if(t)
            string +=$(t).text()+" ";
    } 

    if (string !="") {
      if (string.toUpperCase().indexOf(filter) > -1) {
        tr[i].style.display = "";
      } else {
        tr[i].style.display = "none";
      }
    }       
  }
}

 /*********************SEARCH LIST FUNCTION *************************/
// Live Search tree list
function listSearch(el, target){  // el is the input field, target is the list (ul / ol)
    var a, i, li =[], x, temp, filter ;
    filter = $(el).val().toUpperCase();
    li = $(target).find('li');           

   for (i = 0; i < li.length; i++) {           
            temp = $(li[i]).clone().children('ul').remove().end();
            x = $(temp).text().toUpperCase().indexOf(filter) > -1;
           
        if (!x) {           
            if($(li[i]).parents('li').clone().children('ul').remove().end().text().toUpperCase().indexOf(filter) < 0)
                 $(li[i]).css("display", "none"); 
        }
        else {
            $(li[i]).css("display", "");            
            $(li[i]).parentsUntil(target).css("display", "");
            if($(li[i]).find("*").length > 0)
            $(li[i]).find("*").css("display", "");
           
         }
       
   }
}
/*********************CHECK EXISTING VALUE FUNCTIONS*************************/ //CHECK THIS FUNCTION AGAIN

function checkExistingValue(el, checkArray){
    var val;
    if( checkArray && typeof(checkArray) != 'undefined')
    {          
        val = $(el).val().trim().toUpperCase();  
               
        switch(val){
            case '':
            case null:
                $(el).attr({'title': 'Input value.', 'data-original-title': 'Input value.'});
                            
                return false;
                
            default:            
                if(checkArray && checkArray.includes(val) && !edit)
                {               
                    $(el).attr({'data-validated': 'false', 'title': 'Input is not accecpted.', 'data-original-title': 'Input is not accepted.'});
                    $(el).css('color', 'red');
                    $(el).tooltip();
              

                    return false;
                }           
                else
                {               
                    $(el).attr({'data-validated': 'true', 'title': ' ', 'data-original-title': ''}).css('color', '');
                     //console.log($(el).attr('data-validated'));
                    $('input[name*="save"]').prop('disabled', false); 
                    return true;                  
                }              

        }        
    }
    return true;
}

function validateForm(form){ 
    if(!edit)
    {
        var validated_fields, i, re = false;
        validated_fields = $(form).find('input[data-validated]');
        if(validated_fields.length > 0)
        for(i=0; i < validated_fields.length; i++)
        {
            re = $(validated_fields[i]).attr('data-validated');
          
            if($(validated_fields[i]).attr('data-validated') == 'false')
            {
                re = false;
                break;
            }
        }
        else
            re = true;
      
        return re;
    }
    else
        return true;
    
}
/*********************CLEAR FORM FUNCTION*************************/
// Clear all form fields
function clearForm(){  
    $('#sform').find("input, select, button, textarea").not('.btn').not('input[name*="data"]').not('input[type*="radio"]').val('').prop("disabled", false).css('color', '').attr({'title': '', 'data-original-title': ''});
    $('#sform').find('input.btn').prop("disabled", false);
    $('#sform').find('p.vali-text').text('');
    $('#sform').find('.alter-display').text('');
  //  $('#sform').find('input[type*="radio"][value="0"]').prop('checked', true);
    if($('select').attr('multiple'))
         $('select').select2();
    edit = false; 
}

function editForm(form, arr){
    var i, j, radios, inputs = $(form).find('input, select, textarea, span.radio').not('.btn').not('.select2-search__field').not('input[name*="data"]').not('.radio-input').not('.not-fill');
    
    $("input[name*='id']").parents('.form-group').removeClass('hidden');
    $("input[name*='id']").prop("disabled", true);

    
  
    for(i=0; i < inputs.length; i++)
    {        
        if($(inputs[i]).hasClass('radio')) 
        {          
           radios = $(inputs[i]).find('input');
          
           for(j = 0; j < radios.length; j++)
           {

                ($(radios[j]).val()==arr[i])? $(radios[j]).prop('checked', true): $(radios[j]).prop('checked', false);                
           }                
           
        } 
        if($(inputs[i]).hasClass('hidden'))
            $(inputs[i]).siblings('span.alter-display').text(arr[i]);

        if($(inputs[i]).hasClass('multiple'))
        {    
           
            arr[i]  = JSON.parse("["+arr[i]+"]");
            if(arr[i].length > 0)
            {            
                 $.each(arr[i], function(x, e){           
                    $(inputs[i]).children("option[value='" + e + "']").prop("selected", true);
                    $('select').select2();                            
                });  
            } 
        }
        else
             $(inputs[i]).val(arr[i]);
    }
    
    edit = true;
   
}


function selectRecord(s)
{
        var type, id, name, parent_id,  parent_html, direct_parent_html, project;
       
        {
            type = $(s).attr('data-type');
            id = $(s).children('span.id').text();
            name = $(s).children('span.name').text();            
            project = $('select[name*="project"]').val();

            switch(type){
                case 'section':
                    direct_parent_html = $(s).parents('li.sec');
                    parent_id = '#';                    
                    break
                case 'activity':
                    direct_parent_html = $(s).parents('li.act');
                    parent_html = $(s).parents('li.sec').children(':first');//.clone().wrap('<span></span>').parent().html();                    
                    parent_id = $(s).parents('li.sec').children(':first').children('span.id').text();                
                    break;
                case 'material':
                    direct_parent_html = $(s).parents('li.mat');
                    parent_html = $(s).parents('li.act').children(':first');//.clone().wrap('<span></span>').parent().html();                     
                    parent_id = $(s).parents('li.act').children(':first').children('span.id').text();                
                    break;
                default:
                    break;
            }
           return{
             record : {'id': id, 'parent': parent_id, 'text': id+" - "+name,  'data_type': type, 'project': project}, 
             htmlItem : "<li id=\""+id+"\"><span class=\"selected-record\" data-type="+type+" data-parent-id="+parent_id+"><span class=\"id\">"+id+"</span> - <span class=\"name\">"+name+"</span></li>",
             parent_html: parent_html,
             direct_parent_html: direct_parent_html
            } 
        }
};       


var pwbsSelects = [];
function selectUp(ob) { // Select record and its ascendants
    var i, up = true;
    if (typeof(ob) !='undefined') 
    {
            var item  = selectRecord(ob);
            $(ob).addClass('marked');
            if(item.data_type != 'undefined')            
                pwbsSelects.push(item.record);
            
                        
            for( i = 0; i < pwbsSelects.length; i++)
            {            
                if(item.record.parent == pwbsSelects[i].id)
                {
                    up = false;
                    break;
                }          
                                    
            }
            if(up)
                return selectUp(item.parent_html);
            
    } 
    else 
    {           
            return false;
    }
}

var pWbsDeselects = [];
function selectDown(ob){ // Select record and its children
    var i, down = true, item, children_items;
    if(typeof(ob) != 'undefined')
    {
        item = selectRecord(ob);    
        //pWbsDeselects.push(item.record); 
        children_items = $(item.direct_parent_html).find('span.selected-record');
        if(children_items.length > 0)
        for(i = 0; i < children_items.length; i++)
        {
            item = selectRecord(children_items[i]);
            pWbsDeselects.push(item.record);
            $(children_items[i]).addClass('marked');
        }
           
    
    }
}
function deselectRecord(selectedArr, ob){
     var i = 0;
     if(typeof(ob) != 'undefined')
     {
        var item = selectRecord(ob);     
        for (i=selectedArr.length-1; i >= 0; i--)
        {            
            if(item.record['id'] == selectedArr[i]['id'] && item.record['parent'] == selectedArr[i]['parent'])           
               selectedArr.splice(i, 1);  
             
        }        
       
        $(ob).removeClass('marked').parent('li').children().removeClass('marked');   
        $(item.direct_parent_html).find('span').removeClass('marked');
       // console.log(ob);       
     }
}

function gatherWbsItems(div, cl, callback){ // By div and class
    var items = [], obs;
    osb=$(div).find(cl);
    if(typeof(obs) != 'undefined')
    for(i=0; i < obs.length; i++)
    {
        items.push(selectRecords($(obs[i])));


    }  

    if (callback && typeof(callback) === "function") {
              callback();
   }

}
function displayOptions(el, data) //For item form
{
    var i;  
    $(el).empty(); 
    $(el).append("<option></option>");
    for(i=0; i < data.length; i++)
    {       
        $(el).append("<option value="+data[i][0]+">"+data[i][0]+" - "+data[i][1]+"</option>" );
    }
}

function castOption(lv, callback) // For item form
{
    var serializedData, request;
    $('form select[name="level"]').children("option[value='" + lv + "']").prop("selected", true);
    var target = document.getElementById('parent-field');   									
    serializedData = 'data=item&level='+lv+'&query=fetch_level';    
    request = $.ajax({
        url: "../process/_data-queries.php",
        type: "post",
        data: serializedData,
        success: function(response, status, xhttp) {													
            var data = JSON.parse(response);        
            displayOptions(target, data);   
           
            if (callback && typeof(callback) === "function") {
                callback();
            }

        }
    });		
}
var selectedVal;
function selected(el)
{     
    $(el).children("option[value='" + selectedVal + "']").prop("selected", true);
   
}
function getVal(el)
{
    selectedVal = $(el).val();
   
}

/*****PIN */



/*********************EVENT LISTEN AND EXECUTIONS*************************/
$(document).ready(function(){        
    
   
    loadAll(); // Display on URL params when loading and refresh
    $(document.body).on('click', 'a.menu-link, a.control-link', function(){ 
        setTimeout(function(){
           
            loadAll();}, 3);  //Get uri array and run function after 3/1000 second
    });
    // $('.single-select').select2();
     $(document.body).on('click', 'select[name*="project"]', function(){ 
       pwbsSelects = [];  
    }); 
  
/*********************EDIT RECORD*************************/

 
    $(document.body).on('click', 'a.new-row, a.edit-row', function(){ 
        clearForm();
        var exVal = [], i;
        var tr = $(this).parentsUntil('tbody','tr');
        var td = $(tr).children('td');
        if(td)
        {
            for(i=1; i < td.length; i++)
            {
                exVal[i-1]= $(td[i]).children('span').text();    
            }           
        }
        
                      
        var oldParams = window.location.href;
            oldParams = oldParams.slice(oldParams.indexOf('#')+1);
            
        var diff, i, direct;
         setTimeout(function(){
            var newParams = window.location.href;
            newParams = newParams.slice(newParams.indexOf('#')+1);
             
            if(newParams.includes(oldParams))
            {
                diff = newParams.replace(oldParams,'');
                direct = true;
            }
                
            else if(oldParams.includes(newParams))
            {
                diff = oldParams.replace(newParams,'');
                direct = false;
            }                
                
            if(diff !='')
            {
                
                //loadAll();
                
                diff = parseParameterstoArray(diff);
             
              
                for(i=0; i < diff.length; i++)
                {
                   
                    load('#'+diff[i][0],diff[0][1], function(){                        
                        if(diff[i-1][0]=='divform')
                           if(exVal[0])
                            editForm('#sform', exVal); 
                            editMode('listDiv');
                    });
                }           
            }
            else if(exVal[0])
                editForm('#sform', exVal);           
            
        },3);       
                   
    });

    

    /*********************CLEAR FORM *************************/
    // Clear form button
     $(document.body).on('click', 'input[name*="clear"]', function(){  // Clear form when clear button clicked
         clearForm();
       
    });


   
    /*********************HIERARCHY TREE TOGGLE*************************/
    $(document.body).on('click', '#tree-nav .tree', function(){  //Toggle full hierarchy 
        var treeEl = $(this).siblings().children();
        var targetClass = $(this).attr('data-target');       
        $(targetClass).toggle(250, 'linear');  
        $(treeEl).toggle(200, 'linear');  
        
    }); 
    
    // ****************PROJECT WBS SELECTION************************//
    
    $(document.body).on('click', 'span.record', function(){ 
            
            if(!$(this).hasClass('marked')) // Select records (heirachy element) if not selected 
            {           
                selectUp(this);           
               
            
            }
            else
                deselectRecord(pwbsSelects, this); // if element is selected, remove it 
           
    });

    $(document.body).on('click', 'span.selected-record', function(){  // projectd records 
            
            if(!$(this).hasClass('marked')) 
            {           
                selectDown(this);
              
            }
            else
                deselectRecord(pWbsDeselects, this);
           
    });

     $(document.body).on('click', 'a.edit-wbs', function(){  // projectd records 
           var wbsItem = [ 
                $(this).siblings('span').attr('data-id'), //id
              //  $(this).siblings('span').attr('data-level'), //level: 
                $(this).siblings('span').attr('data-code'), // item_id
                $(this).siblings('span').children('span.name').text(), // name: 
                //$(this).siblings('span').attr('data-parent_code')
                $(this).siblings('span').attr('data-parent'), //parent_code
                 $(this).siblings('span').children('span.desc').text(),
                $(this).siblings('span').attr('data-status')
               
                
           ];
          
           editForm('form', wbsItem); 
           /*
           castOption($(this).siblings('span').attr('data-level'), function (){
                editForm('form', wbsItem); // consider this
           });     */         
           
    });
    /* PIN selected inputs */
  

//********************TO GATHER ALL RECORDS***************/
   // monitorEvents(document.getElementsByTagName("input")[0]);
  


/**********************************AJAX FORM SUBMISSION********************************************/
// Variable to hold request
var request;

// Bind to the submit event of our form
$(document.body).on('click', 'input[type*="submit"]', function(event){   
    // Prevent default posting of form - put here to work in case of errors
    var form = $(this).parentsUntil('#sform','form');
    if($(form).attr('action') != '')
        return;
    event.preventDefault();
	var button; 

    // Abort any pending request
    if (request) {
        request.abort();
    }
    /*****************DATA RESOLUTION*******************************/
	//1. Type 1: Single record query 
    //2. Type 2: Multiple record query
    
    // Let's select and cache all the fields
    var inputs = $(form).find("input, select, textarea, input[type*='submit']");
    $(form).find('input:disabled').removeAttr('disabled');
 
    /*****************END OF DATA RESOLUTION************************/
     var listFile = getParameterByName('divlist');;
     var formFile = getParameterByName('divform');
   
   if(validateForm(form))
    {      
        button = $(event.target); 
        var serializedData = $(form).serialize()
		+ '&'+ encodeURI(button.attr('name'))
        + '='
        + encodeURI(button.attr('value')); // adding clicked button	// 
        var id  = $(form).find("input[name*='id']").val();
        
        if(button.attr('name') == 'save')
        {
            console.log(id_json.includes(id));
            if(typeof(id_json) == 'object' && id_json.includes(id)) // if id exists, query is 'update'
                serializedData += '&' + 'query' + '=' +'update';
            else
            {
                
                serializedData += '&' + 'query' + '=' +'add';
            }
                
 
        }
        if(button.attr('name') == 'delete')
            serializedData += '&' + 'query' + '=' +'delete';
           
    
           // Let's disable the inputs for the duration of the Ajax request.
        // Note: we disable elements AFTER the form data has been serialized.
        // Disabled form elements will not be serialized.
        
        inputs.prop("disabled", true);
        console.log(serializedData);
        // Fire off the request to /form.php
        request = $.ajax({
            url: "../process/_data-queries.php",
            type: "post",
            data: serializedData,
            success: function( data, status, xhttp) {
                // data will be true or false if you returned a json bool
                var notice, q;
              //  console.log(data);                
               // q = JSON.parse(data);
             //   notice = q['query'] + ' succeeded'; 
                edit = false;
                //console.log(notice);
                $("span#form-notice").text(notice).addClass('text-success').fadeOut(3500);
                load("#divlist", listFile); 
                load("#divform", formFile);     

            }
        });
         request.done(function (response, textStatus, jqXHR){        
		   console.log(response);	    
		
        });
        
         request.fail(function (jqXHR, textStatus, errorThrown){
        // Log the error to the console
            console.error(
                "The following error occurred: "+
                textStatus, errorThrown
            );
        });

    // Callback handler that will be called on success
    // Callback handler that will be called on failure
    // Callback handler that will be called regardless
    // if the request failed or succeeded
        request.always(function () {
        // Reenable the inputs
        inputs.prop("disabled", false);
        clearForm();
		// fucntion 

        });
    }
});
/**********************************END OF AJAX FORM SUBMISSION********************************************/



});









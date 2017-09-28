

/* TREE PROCESS */

function selectRecord(s, arr)
{
       var selected_code, selected_id, parent_code, next, index;
    
       if(!$(s).hasClass('fancytree-active') && !$(s).hasClass('fancytree-selected'))
       {
            selected_id   = parseInt($(s).attr('data-id')); 
            selected_code = parseInt($(s).attr('data-code'));     
            parent_code   = parseInt($(s).attr('data-parent_code'));  
                      
            index = arr.indexOf(selected_code);
            if(index < 0)
            {
                if(selected_code)
                {
                    arr.push({'id': selected_id, 'code': selected_code});
                    $(s).addClass('fancytree-active');  
                }
            }           
            
            if(!isNaN(parent_code))            {               
                next = $(s).parent().parent('ul').siblings('span.fancytree-node');             
                selectRecord(next, arr) ;  
            }
       }
         
};  
function singleSelect(s, arr)
{
       var selected_code, selected_id, parent_code, next, index;
    
       if(!$(s).hasClass('fancytree-active') && !$(s).hasClass('fancytree-selected'))
       {
            selected_id   = parseInt($(s).attr('data-id')); 
            selected_code = parseInt($(s).attr('data-code'));     
            parent_code   = parseInt($(s).attr('data-parent_code'));  
                      
            index = arr.indexOf(selected_code);
            if(index < 0)
            {
                if(selected_code)
                {
                    arr.push({'id': selected_id, 'code': selected_code});
                    $(s).addClass('fancytree-active');  
                }
            }         
           
       }
         
};
function deselectRecord(s, arr){
   
     var deselect_id, deselect_code, index, children;
     if(typeof(s) != 'undefined')
     {   
        deselect_code = parseInt($(s).attr('data-code'));
        children = $(s).siblings('ul').find('li>span.fancytree-active');  
        for(var i = 0; i < arr.length; i++) {
            if(arr[i].code == deselect_code) {
                arr.splice(i, 1);
                break;
            }
        }

        index = arr.indexOf(deselect_code);
        if(index > -1)
            arr.splice(index, 1);       
        $(s).removeClass('fancytree-active');   
        
       
        if(children.length > 0)
        {   
            for(var i = 0; i < children.length;  i++)
            {
                deselect_code = parseInt($(children[i]).attr('data-code'));
                 for(var i = 0; i < arr.length; i++) {
                    if(arr[i].code == deselect_code) {
                        arr.splice(i, 1);
                        $(children[i]).removeClass('fancytree-active');
                        break;
                    }
                }              
            }
        }                
     }
     console.log(arr);

}


function selectDown(s, arr){ // Select record and its children
    var select_id, select_code, children;
    if(typeof(s) != 'undefined')
    {
        select_code = parseInt($(s).attr('data-code'));
        select_id = parseInt($(s).attr('data-id'));
        index = arr.indexOf(select_code);
    
        arr.push({'id': select_id, 'code': select_code}); 
        $(s).addClass('fancytree-active');   
        children = $(s).siblings('ul').find('span.fancytree-node');
        if(children.length > 0)
        {   
            for(var i = 0; i < children.length;  i++)
            {
                 select_id = parseInt($(s).attr('data-id'));
                select_code = parseInt($(children[i]).attr('data-code'));
                arr.push({'id': select_id, 'code': select_code});                 
                $(children[i]).addClass('fancytree-active');                
            }
        }             
    
    }
    console.log(arr);
}

$(document).ready(function(){
    var project_id = getParameterByName('pid');
    var pWbsDeselects = [], pwbsSelects = [], pwbsxSelects = [];
    //Build array of codes in pwbs
    $(function()
    {
        var pwbs_nodes = $('#pwbs-tree').find('span.fancytree-node')
        var pwbs_codes =[];
        var pri_leaves = []; // parent_code in pwbsx
        var pri_nodes = pwbs_nodes.not('span.ext');
        var i = 0;
      
        for(; i < pwbs_nodes.length; i++)
        {
            pwbs_codes.push($(pwbs_nodes[i]).attr('data-code'));
            if(!($(pwbs_nodes[i]).parent('li').children('ul').length > 0) || $(pwbs_nodes[i]).parent('li').children('ul').find('span.ext').length >0 )
            {
                pri_leaves.push({'code':$(pwbs_nodes[i]).attr('data-code'), 'name': $(pwbs_nodes[i]).attr('data-name')});
            }       
          
        } 
          
        
        var wbs_nodes = $('#wbs-tree').find('span.fancytree-node')
        var wbs_codes =[];
    
        for(i=0; i < wbs_nodes.length; i++)
        {
            wbs_codes.push($(wbs_nodes[i]).attr('data-code'));
        }    

        pwbs_codes.some(function(e)
        {        
            if(wbs_codes.indexOf(e)>0)
            {            
                var str = '#wbs-tree li#'+e;             
                $('#wbs-tree li#'+e).children('span.fancytree-node').addClass('fancytree-selected');
            }

        });

        $(function() // Insert dropdown options to parent_code select 
        {
            $.each(pri_leaves, function() 
            {           
                $('select#parent_code').append($('<option></option>').text(this.code+' - '+this.name).val(this.code));
            });
        });
    });
    // ****************PROJECT WBS SELECTION************************/    
    $(document.body).on('click', '#wbs-tree .fancytree-node', function(){         
        if(!$(this).hasClass('fancytree-active') & !$(this).hasClass('fancytree-selected')) // Select records (heirachy element) if not selected                    
            selectRecord(this, pwbsSelects);         
        else if($(this).hasClass('fancytree-active'))
            deselectRecord(this, pwbsSelects); // if element is selected, remove it 
        console.log(pwbsSelects);   
    });  

    $(document.body).on('click', '#pwbs-tree .fancytree-node', function(){  // projectd records         
        if(!$(this).hasClass('fancytree-active'))                    
            selectDown(this, pWbsDeselects);         
        else 
            deselectRecord(this, pWbsDeselects);
        console.log(pWbsDeselects);            
    });

    $(document.body).on('click', '#pwbsx-tree .fancytree-node', function(){         
        if(!$(this).hasClass('fancytree-active') && !$(this).hasClass('fancytree-selected') && ($(this).parent('li').children('ul').length == 0)) // Select records (heirachy element) if not selected                    
            singleSelect(this, pwbsxSelects);         
        else if($(this).hasClass('fancytree-active'))
            deselectRecord(this, pwbsxSelects); // if element is selected, remove it 
        console.log(pwbsxSelects);           
    });    

    $(document.body).on('click', 'a.edit-wbs', function(){  // projectd records 
           var wbsItem = editedRecord(this);
          
           editForm('form', wbsItem); 
          
           castOption($(this).siblings('span').attr('data-level'), function (){
                editForm('form', wbsItem); // consider this
           });          
           
    });

    $(document.body).on('click', '#wbs-tree .move', function(event)
    { 
        var project, form_file, name, div, file, data, dash, project_employee;
        
        var pid = getParameterByName('pid');  
        
        request = $.ajax({
            url: "../process/services/_dispatcher.php",
            type: "post",
            data: {'query': 'add_pwbs',
                    'pid': pid, 
                    'data': pwbsSelects},
            success: function(response, status, xhttp) {               
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
    
        });    
    
    });   

    $(document.body).on('click', '#pwbs-tree .remove', function(event){ 
      
        var project, form_file, name, div, file, data, dash, project_employee;
        
        var pid = getParameterByName('pid');  
        
        request = $.ajax({
            url: "../process/services/_dispatcher.php",
            type: "post",
            data: {'query': 'remove_pwbs',
                    'pid': pid, 
                    'data': pWbsDeselects},
            success: function(response, status, xhttp) {               
                 console.log(response);
            }
        });       
    
    });
    $(document.body).on('click', 'button[name*="insert_pwbsx"]', function(){        
        var fields = $('fieldset[form="wbsx"]').find('input, textarea, radio, buttun, select');
        var serializedData = $(fields).serialize()+'&query=insert_pwbsx&project_id='+getParameterByName('pid');      
        
         request = $.ajax({
            url: "../process/services/_dispatcher.php",
            type: "post",
            data: serializedData,
            success: function(response, status, xhttp) {               
                 console.log(response);
            }
        });
    });

    $(document.body).on('click', 'button[name*="quantify"]', function(){        
    var fields = $('fieldset[form="wbsx"]').find('input, textarea, radio, buttun, select');
          request = $.ajax({
            url: "../process/services/_dispatcher.php",
            type: "post",
            data: {'query': 'quantify_pwbsx',
                   'project_id': getParameterByName('pid'),
                   'data': pwbsxSelects},
            success: function(response, status, xhttp) {               
                 console.log(response);
            }
        });
    });
    $(document.body).on('click', 'button[name*="de-quantify"]', function(){        
    var fields = $('fieldset[form="wbsx"]').find('input, textarea, radio, buttun, select');
          request = $.ajax({
            url: "../process/services/_dispatcher.php",
            type: "post",
            data: {'query': 'de-quantify_pwbsx',
                   'project_id': getParameterByName('pid'),
                   'data': pwbsxSelects},
            success: function(response, status, xhttp) {               
                 console.log(response);
            }
        });
    });



/**********************************GROUP DATA TABLE (HANDSONTABLE)*********************************/
/*
var
  $container = $("#group");
 
  var $console = $("#exampleConsole"),
  $parent = $container.parent(),
  autosaveNotification,
  hot;

hot = new Handsontable($container[0], {
  colHeaders: ['#', 'Jid', 'Name', 'Desc', 'Deadline', 'Status'], 
  startRows: 1,
  startCols: 6,
  minSpareRows: 1,
  rowHeaders: true,
  columnSorting: true,
  stretchH: 'all',
  contextMenu: true, 
  manualColumnResize: true, 
  columns:[
      {
        data: 'id',
        readOnly: true
      },
      {
        data: 'jid',
        readOnly: true
      },
      {
          data: 'name'
      },
      {
          data: 'description'
      },
      {
          data: 'to_date'
      },
      {
          data: 'status',
          readOnly: true
      }

  ],
  afterChange: function (change, source) {
    var data, row, r, key;
    console.log(change);
    if(change)
    {
        row = change[0];
        row[0] = hot.sortIndex[row[0]] ? hot.sortIndex[row[0]][0] : row[0];
        r = this.getDataAtRow(row[0]);
        data = { 'id': r[0], [row[1]] : row[3], 'query': 'insert_group', 'project_id': project_id};
       
        console.log(data);
         clearTimeout(autosaveNotification);
        $.ajax({
        url: "../process/services/_dispatcher.php",
        dataType: 'json',
        type: 'POST',
        data: data, // contains changed cells' data
        success: function (res) {
            /*
            $console.text('Autosaved (' + change.length + ' cell' + (change.length > 1 ? 's' : '') + ')');

            autosaveNotification = setTimeout(function () {
            $console.text('Changes will be autosaved');
            }, 1000);
        }
        });
        
    }
 
    if (source === 'loadData' || !$parent.find('input[name=autosave]').is(':checked')) {
      return;
    }
    
    

    // transform sorted row to original row
    
   
   
  }
});
/* LOAD DATA TO TABLE *//*
var loadGroup = $.ajax({
    url: "../process/services/_group.php",
    dataType: 'json',
    type: 'GET',
    data:{'query': 'load_group',
          'project_id': getParameterByName('pid')},
    success: function (res) {
      hot.loadData(res);
    }
});
loadGroup.done(function (response, textStatus, jqXHR){        
     	    
    
});
        

*/
    

   

});



/**********************************END OF AJAX FORM SUBMISSION********************************************/
/*

//$(document).ready('button[name=load]').click(function () {

//}).click(); // execute immediately

$parent.find('button[name=save]').click(function () {
  $.ajax({
    url: 'php/save.php',
    data: {data: hot.getData()}, // returns all cells' data
    dataType: 'json',
    type: 'POST',
    success: function (res) {
      if (res.result === 'ok') {
        $console.text('Data saved');
      }
      else {
        $console.text('Save error');
      }
    },
    error: function () {
      $console.text('Save error');
    }
  });
});

$parent.find('button[name=reset]').click(function () {
  $.ajax({
    url: 'php/reset.php',
    success: function () {
      $parent.find('button[name=load]').click();
    },
    error: function () {
      $console.text('Data reset failed');
    }
  });
});

$parent.find('input[name=autosave]').click(function () {
  if ($(this).is(':checked')) {
    $console.text('Changes will be autosaved');
  }
  else {
    $console.text('Changes will not be autosaved');
  }
});
*/

/*
$(function() {
  var hot_populate_data = [
        [1, "George Washington", "http://en.wikipedia.org/wiki/George_Washington", "30/04/1789", "4/03/1797", "Virginia"],
        [2, "John Adams", "http://en.wikipedia.org/wiki/John_Adams", "4/03/1797", "4/03/1801", "Massachusetts"],
        [3, "Thomas Jefferson", "http://en.wikipedia.org/wiki/Thomas_Jefferson", "4/03/1801", "4/03/1809", "Virginia"],
        [4, "James Madison", "http://en.wikipedia.org/wiki/James_Madison", "4/03/1809", "4/03/1817", "Virginia"],
        [5, "James Monroe", "http://en.wikipedia.org/wiki/James_Monroe", "4/03/1817", "4/03/1825", "Virginia"],
        [6, "John Quincy Adams", "http://en.wikipedia.org/wiki/John_Quincy_Adams", "4/03/1825", "4/03/1829", "Massachusetts"],
        [7, "Andrew Jackson", "http://en.wikipedia.org/wiki/Andrew_Jackson", "4/03/1829", "4/03/1837", "Tennessee"],
        [8, "Martin Van Buren", "http://en.wikipedia.org/wiki/Martin_Van_Buren", "4/03/1837", "4/03/1841", "New York"],
        [9, "William Henry Harrison", "http://en.wikipedia.org/wiki/William_Henry_Harrison", "4/03/1841", "4/04/1841", "Ohio"],
        [10, "John Tyler", "http://en.wikipedia.org/wiki/John_Tyler", "4/04/1841", "4/03/1845", "Virginia"],
        [11, "James K. Polk", "http://en.wikipedia.org/wiki/James_K._Polk", "4/03/1845", "4/03/1849", "Tennessee"],
        [12, "Zachary Taylor", "http://en.wikipedia.org/wiki/Zachary_Taylor", "4/03/1849", "9/07/1850", "Louisiana"]
    ];

    function firstRowRenderer(instance, td, row, col, prop, value, cellProperties) {
        Handsontable.renderers.TextRenderer.apply(this, arguments);

        // Add styles to the table cell
        td.style.fontWeight = '500';
        td.style.color = '#1B5E20';
        td.style.background = '#E8F5E9';
    }
  

    // Cells template
    var tpl = ['#', 'Jid', 'Name', 'Desc', 'Deadline', 'Status'];

    // Render empty row
    function isEmptyRow(instance, row) {
        var rowData = instance.getData()[row];

        for (var i = 0, ilen = rowData.length; i < ilen; i++) {
            if (rowData[i] !== null) {
                return false;
            }
        }

        return true;
    }

    // Render default values
    function defaultValueRenderer(instance, td, row, col, prop, value, cellProperties) {
        var args = arguments;

        if (args[5] === null && isEmptyRow(instance, row)) {
            args[5] = tpl[col];
            td.style.color = '#ccc';
        }
        else {
            td.style.color = '';
        }
        Handsontable.renderers.TextRenderer.apply(this, args);
    }

    // Define element
    var hot_populate = document.getElementById('hot_populate')

    // Initialize with options
    var hot_populate_init = new Handsontable(hot_populate, {
        data: hot_populate_data,
        colHeaders: ['#', 'Jid', 'Name', 'Desc', 'Deadline', 'Status'],
        startRows: 8,
        startCols: 5,
        minSpareRows: 1,       
        rowHeaders: true,
        columnSorting: true,
        stretchH: 'all',
        contextMenu: true,
        maxSpareRows: 1,
        cells: function (row, col, prop) {
            var cellProperties = {};
            cellProperties.renderer = defaultValueRenderer;       

            return cellProperties;
        },
        beforeChange: function (changes) {
            var instance = hot_populate_init,
            ilen = changes.length,
            clen = instance.colCount,
            rowColumnSeen = {},
            rowsToFill = {},
            i,
            c;

            for (i = 0; i < ilen; i++) {

                // If oldVal is empty
                if (changes[i][2] === null && changes[i][3] !== null) {
                    if (isEmptyRow(instance, changes[i][0])) {

                        // Add this row/col combination to cache so it will not be overwritten by template
                        rowColumnSeen[changes[i][0] + '/' + changes[i][1]] = true;
                        rowsToFill[changes[i][0]] = true;
                    }
                }
            }

            for (var r in rowsToFill) {
                if (rowsToFill.hasOwnProperty(r)) {
                    for (c = 0; c < clen; c++) {

                        // If it is not provided by user in this change set, take value from template
                        if (!rowColumnSeen[r + '/' + c]) {
                            changes.push([r, c, null, tpl[c]]);
                        }
                    }
                }
            }
        }
    });


    // Define element
    var packaging = document.getElementById('packaging')

    // Initialize with options
    var hot_populate_init = new Handsontable(packaging, {
        data: hot_populate_data,
        colHeaders: ['#', 'Jid', 'Name', 'Desc', 'Deadline', 'Status'],
        startRows: 8,
        startCols: 5,
        minSpareRows: 1,       
        rowHeaders: true,
        columnSorting: true,
        stretchH: 'all',
        contextMenu: true,
        maxSpareRows: 1,
        cells: function (row, col, prop) {
            var cellProperties = {};
            cellProperties.renderer = defaultValueRenderer;       

            return cellProperties;
        },
        beforeChange: function (changes) {
            var instance = hot_populate_init,
            ilen = changes.length,
            clen = instance.colCount,
            rowColumnSeen = {},
            rowsToFill = {},
            i,
            c;

            for (i = 0; i < ilen; i++) {

                // If oldVal is empty
                if (changes[i][2] === null && changes[i][3] !== null) {
                    if (isEmptyRow(instance, changes[i][0])) {

                        // Add this row/col combination to cache so it will not be overwritten by template
                        rowColumnSeen[changes[i][0] + '/' + changes[i][1]] = true;
                        rowsToFill[changes[i][0]] = true;
                    }
                }
            }

            for (var r in rowsToFill) {
                if (rowsToFill.hasOwnProperty(r)) {
                    for (c = 0; c < clen; c++) {

                        // If it is not provided by user in this change set, take value from template
                        if (!rowColumnSeen[r + '/' + c]) {
                            changes.push([r, c, null, tpl[c]]);
                        }
                    }
                }
            }
        }
    });


    // Highlighting current
    // ------------------------------
/*
    // Define element
    hot_highlight = document.getElementById('hot_highlight');

    // Initialize with options
    hot_highlight_init = Handsontable(hot_highlight, {
        data: hot_data,
        minRows: 5,
        minCols: 6,
        stretchH: 'all',
        currentRowClassName: 'active',
        currentColClassName: 'active',
        rowHeaders: true,
        colHeaders: true
    });

    // Select cell
    hot_highlight_init.selectCell(2,2);



    // Bootstrap integration
    // ------------------------------

    // Define element
    var hot_bootstrap = document.getElementById('hot_bootstrap');

    // Init with options
    hot_bootstrap_init = new Handsontable(hot_bootstrap, {
        data: hot_data,
        colHeaders: true,
        stretchH: 'all',
        fixedColumnsLeft: 2,
        tableClassName: ['table-hover', 'table-striped']
    });

    

});

*/







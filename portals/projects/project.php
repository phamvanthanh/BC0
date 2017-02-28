<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta name="robots" content="noindex">

<title>cschema | The Construction schema</title>
<link href="/ico/logo.png" rel="icon" >
<link rel="stylesheet" href="../css/bootstrap.min.css">
<link href="../css/bootstrap-theme.css" rel="stylesheet" />
<script src="../js/jquery.min.js"></script>
<script src="../js/bootstrap.min.js"></script>

<link href="../css/cschema.css" rel="stylesheet" />
<style>
a#menu-1 {
    font-weight: bold;
}
.panel-footer {
  width: 100%;
  position: absolute;
  bottom: 0px;
  margin:0px;
  padding: 0px;
  border-top: 1px solid #CCCCCC;
  
  background-color: #ffffff;
  color: #1c2127
}
.panel-footer .container {
  margin-top: 0px;
  margin-right: 0px;
  margin-left: auto;
  margin-right: auto
}
.panel-footer .container p{
  line-height: 30px;
  margin: 0px;
  padding: 0px
  
}
</style>
</head>
<body>
<?php    
    session_start();	
    error_reporting(E_ALL);
    ini_set('display_errors', 1);
   // if(isset($_SESSION['valid']))
    {      

        include_once('../process/_cschema-connect.php');
        include_once('../process/_functions.php');
        $pid = htmlspecialchars($_GET["pid"]);
        //$_SESSION['projectId'] = $pid;
        $project = fetchProject($conn, $pid)[0];       
    
       
       
    }
   // else
    //    header('Location: login.php');
                    
?>
<header>
  <?php include_once('../includes/header.php'); ?>
</header>
<table  width="100%" cellpadding="2" cellpadding="10" >
    <tr class="info"  >
        <td colspan="3" align="center" valign="middle" style="padding: 3px"   >
                Search: <input type="text" onkeyup="listSearch(this, '#dash')" placeholder="Search.." title="Type in a name" style="width: 30%; height: 22px">
        </td>
    </tr>
    <tr>
        <td colspan="2" height="20px" >
                
        </td>
    </tr>
</table>
<div >

   
            <table  width="100%" cellpadding="0" cellspacing="0" border="0" >
                <tbody >
                    <tr>
                        <td nowrap="nowrap" width="20%" style=" border-right: 2px solid white; padding-left: 2px" class="h4 info"  >
                             <?php echo "Project ".$pid ?>
                        </td>
                        <td width="65%"  class="info" style="border-right: 2px solid white; padding-left: 2px" >
                            <span  class="h4" ><?php echo $project[1]; ?></span>
                        </td>
                        <td width="15%" class="info" style="padding-left: 2px">
                           
                        </td>
                         
                    </tr>
                    <tr style="border-bottom: 2px solid white">
                        <td class="info" style="border-right: 2px solid white; padding-left: 2px" >
                             
                        </td class="info">
                        <td class="info" style="border-right: 2px solid white; padding-left: 2px">
                            <span><?php echo "Industry: ".$project[4].", Opened time: ".$project[17]; ?></span>
                        </td>
                        <td  class="info" style="padding-left: 0.3em; padding-right:.3em">
                            <a  data-toggle="modal" data-target="#joinProjectModal" >Join project </a>
                        </td>
                      
                    
                    </tr>
                    <tr>
                        <td valign="top" class="info" style="padding-left: 2px" >
                            <table cellspacing="0" cellpadding="0">
                                <tbody>
                                    <tr>
                                        <th align="left" style="padding-right:.3em" >Controller: </th>
                                        <td width="100%" ><?php echo $project[9]. " ".$project[10] ; ?></td>
                                    </tr>
                                      <tr>
                                        <th align="left" style="padding-right:.3em" >CC: </th>
                                        <td width="100%" ><?php echo $project[11]; ?></td>
                                    </tr>
                                    <tr>
                                        <th align="left" style="padding-right:.3em" >Nationality: </th>
                                        <td width="100%" ><?php echo $project[2]; ?></td>
                                    </tr>
                                    <tr>
                                        <th align="left" style="padding-right:.3em" >Con. date: </th>
                                        <td width="100%" ><?php echo $project[13]; ?></td>
                                    </tr>
                                      <tr>
                                        <th align="left" style="padding-right:.3em" >Close date: </th>
                                        <td width="100%" ><?php echo $project[14]; ?></td>
                                    </tr>                                   
                                      <tr>
                                        <th align="left" style="padding-right:.3em" >Docs.: </th>                                       
                                        <td><?php echo "<a href=\"".$project[12]."\">link</a>" ?></td>
                                    </tr>
                                
                                     <tr>
                                        <th align="left" style="padding-right:.3em" >Status: </th>                                       
                                        <td><?php echo $status = ($project[16]== 0)? 'Open': 'Closed' ?> </td>
                                    </tr>
                                    <tr>
                                        <th colspan="2" align="left" style="padding-right:.3em" >Summary: </th>                                       
                                        
                                    </tr>
                                    <tr>
                                        <td colspan="2" align="left" style="padding-right:.3em" ><?php if($project[15] != '' && $project[15] != null ) echo $project[15]; else echo "---"; ?></td>                                       
                                        
                                    </tr>
                                </tbody>
                            </table>

                        </td>
                        <td colspan="3" >
                            <div id="dash" style="padding: 5px">
                                <?php
                                    
                                    

                                    
                                   //if(isset($_SESSION['projectId']))
                                    {
                                        
                                        $activity_data = fetchData($conn, "activity");
                                        $material_data = fetchData($conn, "material");
                                    
                                        $project_section_data = projectSectionFetch($conn, $pid );
                                        $project_activity_data = fetchProjectFK($conn, "project_activity", $pid );
                                        $project_material_data = fetchProjectFK($conn, "project_material", $pid );
                                        //var_dump($project_activity_data);
                                        echo "<ul  >";
                                            for($i = 0; $i < sizeof($project_section_data); $i++)
                                            {
                                                
                                                    echo "<li id=".$project_section_data[$i][0]." class=\"sec\" >";
                                                    echo "<span class=\"selected-record\" data-type=\"section\" ><span class=\"id\">".$project_section_data[$i][0]."</span>"." - "."<span class=\"name\">".$project_section_data[$i][1]."</span></span>";
                                                    
                                                    $data2 = displayData($activity_data, $project_activity_data, $project_section_data[$i][0]);
                                                    //var_dump($data2);
                                                    echo "<ul id=\"sec$i\" class=\"collapse in\" >";
                                                        for($j = 0; $j <sizeof($data2); $j++ )
                                                        {
                                                            echo "<li id=".$project_activity_data[$i][0]." class=\"act\" >";
                                                                echo "<span class=\"selected-record\" data-type=\"activity\"  ><span class=\"id\">".$data2[$j][0]."</span>"." - "."<span class=\"name\">".$data2[$j][1]."</span></span>";
                                                                $data3 = displayData($material_data, $project_material_data, $data2[$j][0]);								
                                                                echo "<ul id=\"act$i$j\" class=\"collapse in\" >";
                                                                        for($k = 0; $k < sizeof($data3); $k++)
                                                                        {
                                                                            echo "<li id=".$material_data[$k][0]." class=\"mat\" >
                                                                                        <span class=\"selected-record\" data-type=\"material\"  ><span class=\"id\">".$data3[$k][0]."</span>"." - "."<span class=\"name\">".$data3[$k][1]."</span></span>";
                                                                                        
                                                                            echo "</li>";
                                                                        }
                                                                echo "</ul>";

                                                            echo "</li>";
                                                        }
                                                    echo "</ul>";
                                                echo "</li>";
                                            }
                                        echo "</ul>";
                                    }	
                                ?>

                            </div>
                        </td>
                    </tr>

                </tbody>
            </table>  

</div>
<div class="modal fade" id="joinProjectModal" role="dialog">
    <div class="modal-dialog">
    
      <!-- Modal content-->
      <div id="sform" class="modal-content">
       <?php if(isset($_SESSION["valid"])) { ?>
         <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal">&times;</button>
          <h4 class="modal-title">Subcribe project</h4>
        </div>
        <div id="modalBody" class="modal-body"   >                 
                    <form id="psubform" action=''>
                        <div id="polgrap" style="height: 400px; overflow-y:auto" >
                            <p>By subcribing to the project, you agree with our pre-set conditions as below:</p>
                            <div class="jumbotron">
                                <p style="font-size: 14px" > - Project information policy.<br>
                                        - Information copyright.<br>
                                        - Progress obligation.<br>
                                        - User's responsibilties'.<br>
                                        - Postponse project.<br>
                                        - Payment.<br>
                                        - Mantainance.
                                </p>
                                <p style="font-size: 14px" > - Project information policy.<br>
                                        - Information copyright.<br>
                                        - Progress obligation.<br>
                                        - User's responsibilties'.<br>
                                        - Postponse project.<br>
                                        - Payment.<br>
                                        - Mantainance.
                                </p>
                                <p style="font-size: 14px" > - Project information policy.<br>
                                        - Information copyright.<br>
                                        - Progress obligation.<br>
                                        - User's responsibilties'.<br>
                                        - Postponse project.<br>
                                        - Payment.<br>
                                        - Mantainance.
                                </p>
                                <p style="font-size: 14px" > - Project information policy.<br>
                                        - Information copyright.<br>
                                        - Progress obligation.<br>
                                        - User's responsibilties'.<br>
                                        - Postponse project.<br>
                                        - Payment.<br>
                                        - Mantainance.
                                </p>
                            </div>
                        </div>
                        <div class="checkbox">
                                    <input class="hidden" type="text" name="projectId" value="<?php echo $pid; ?>" >
                                    <input class="hidden" type="text" name="employeeId" value="<?php echo $_SESSION['userId'] ?>" >
                                    <input class="hidden" type="text" name="data" value="project_employee">
                            <label  ><input id="subcheck" type="checkbox" value="">I agree with the condition.</label>
                            <label  ><input id="subbtn" type="submit" name="save" value="Subcribe" disabled></label>
                            <script>
								$(document).ready(function(){ 
									$('#subcheck').change(function(){                                        
                                        $(this).prop('checked') ? $('#subbtn').attr('disabled', false): $('#subbtn').attr('disabled', true); 
                                    });
							})
							</script>
                        </div>
                        
                    </form> <?php }
                else
                { ?>
                     <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title">Sign in</h4>
                    </div>
                    <div class="modal-body">
                          
                          <form action="process/_login.php" method="post" >
                            <div class="form-group">
                                <input type="text" name="email" placeholder="Email address">
                            </div>
                            <div class="form-group">
                                <input type="password" name="password" placeholder="Password">
                            </div>
                            <div class="checkbox">
                                
                            </div>
                            <div class="form-group">
                                <input class="btn btn-primary btn-sm" type="submit" name="login" value="Login">
                                <div class="text-center">
                                
                                </div>
                            </div>
                        </form>



                <?php } ?>   
                
        </div>
        <div class="modal-footer">
         
        </div>
      </div>
      
    </div>
  </div>
<script>
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
  
    var inputs = $(form).find("input, select, textarea, input[type*='submit']");
    $(form).find('input:disabled').removeAttr('disabled');
	 


    /*****************END OF DATA RESOLUTION************************/
     var list = $('input[name*="data"]').val() +'_list';
    
  // if(validateForm(form))
    {      
        button = $(event.target); 
        var serializedData = $(form).serialize()
		+ '&'+ encodeURI(button.attr('name'))
        + '='
        + encodeURI(button.attr('value')); // adding clicked button	// 
        var id  = $(form).find("input[name*='id']").val();
        
        if(button.attr('name') == 'save')
        {
            if(typeof(id_json) != 'undefined' && id_json.includes(id)) // if id exists, query is 'update'
                serializedData += '&' + 'query' + '=' +'update';
            else
                serializedData += '&' + 'query' + '=' +'add';
 
        }
        if(button.attr('name') == 'delete')
            serializedData += '&' + 'query' + '=' +'delete';
           
    
     
       // inputs.prop("disabled", true);
        console.log(serializedData);
        // Fire off the request to /form.php
        request = $.ajax({
            url: "process/_data-queries.php",
            type: "post",
            data: serializedData,
            success: function( data, status, xhttp) {
                console.log(data);	
                $("#modalBody").html("Thank you for subcribing the project! <br> Our representative may contact you."); 
               // $("#joinProjectModal").modal();   

            }
        });
         request.done(function (response, textStatus, jqXHR){        
		  // console.log(response);	    
		
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
      

        });
    }
});

</script>
<script>
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
</script>
<div class="panel-footer">
	<div class="container">					
		<p class="text-center">&copy; 2017 QsCompanion.</p>
	</div>
</div>
</body>
</html>
 
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
.onoffswitch {
    position: relative; width: 72px;
    -webkit-user-select:none; -moz-user-select:none; -ms-user-select: none;
}
.onoffswitch-checkbox {
    display: none;
}
.onoffswitch-label {
    display: block; overflow: hidden; cursor: pointer;
    border: 2px solid #999999; border-radius: 0px;
}
.onoffswitch-inner {
    display: block; width: 200%; margin-left: -100%;
    transition: margin 0.3s ease-in 0s;
}
.onoffswitch-inner:before, .onoffswitch-inner:after {
    display: block; float: left; width: 50%; height: 18px; padding: 0; line-height: 18px;
    font-size: 14px; color: white; font-family: Trebuchet, Arial, sans-serif; font-weight: bold;
    box-sizing: border-box;
}
.onoffswitch-inner:before {
    content: "Edit";
    padding-left: 10px;
    background-color: #34A7C1; color: #FFFFFF;
}
.onoffswitch-inner:after {
    content: "Edit";
    padding-right: 10px;
    background-color: #EEEEEE; color: #999999;
    text-align: right;
}
.onoffswitch-switch {
    display: block; width: 8px; margin: 5px;
    background: #FFFFFF;
    position: absolute; top: 0; bottom: 0;
    right: 50px;
    border: 2px solid #999999; border-radius: 0px;
    transition: all 0.3s ease-in 0s; 
}
.onoffswitch-checkbox:checked + .onoffswitch-label .onoffswitch-inner {
    margin-left: 0;
}
.onoffswitch-checkbox:checked + .onoffswitch-label .onoffswitch-switch {
    right: 0px; 
}

a#menu-2 {
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
   if(isset($_SESSION['valid']))
    {      

        include_once('../process/_cschema-connect.php');
        include_once('../process/_functions.php');
        $pid = htmlspecialchars($_GET["pid"]);    
        $project = fetchProject($conn, $pid)[0];       
    
       
       
    }
    else
       header('Location: /login.php');
                    
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
                           <div class="onoffswitch">
						   		
								<input type="checkbox" name="onoffswitch" class="onoffswitch-checkbox"  id="myonoffswitch">
								<label class="onoffswitch-label" for="myonoffswitch">
									<span class="onoffswitch-inner"></span>
									<span class="onoffswitch-switch"></span>
								</label>
							</div>
							<script>
								$(document).ready(function(){ 
									$('#myonoffswitch').change(function(){
									
										if($(this).prop('checked'))
										{
											$('#dash').addClass('hidden');
											$('#inputTable').removeClass('hidden');											
										}
										else
										{
											$('#dash').removeClass('hidden');
											$('#inputTable').addClass('hidden');
										}

									})
							})
							</script>
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
									
									
									if(isset($_SESSION['valid'])  && isset($_SESSION['userId'])) // Condition for project and employee
									{
										
									
									
										$activity_data = fetchData($conn, "activity");
										$material_data = fetchData($conn, "material");
										$emp_pwbs_section = employeePwbsSectionFetch($conn, $pid, $_SESSION['userId']);  
										$emp_pwbs_activity = fetchEmployeePwbs($conn, "emp_project_activity", $_SESSION['userId'], $pid);  
										$emp_pwbs_material = fetchEmployeePwbs($conn, "emp_project_material", $_SESSION['userId'], $pid);  	
										
										
										echo "<ul  >";
											for($i = 0; $i < sizeof($emp_pwbs_section); $i++)
											{
										
												
													echo "<li id=".$emp_pwbs_section[$i][0]." class=\"sec\" >";
													echo "<span class=\"selected-record\" data-type=\"section\" ><span class=\"id\">".$emp_pwbs_section[$i][0]."</span>"." - "."<span class=\"name\">".$emp_pwbs_section[$i][1]."</span></span>";
													
													$data = displayData($activity_data, $emp_pwbs_activity, $emp_pwbs_section[$i][0]);
													
													echo "<ul id=\"sec$i\" class=\"collapse in\" >";
														for($j = 0; $j <sizeof($data); $j++ )
														{
															echo "<li id=".$data[$j][0]." class=\"act\" >";
																echo "<span class=\"selected-record\" data-type=\"activity\"  ><span class=\"id\">".$data[$j][0]."</span>"." - "."<span class=\"name\">".$data[$j][1]."</span></span>";
																$data1 = displayData($material_data, $emp_pwbs_material, $data[$j][0]);								
																echo "<ul id=\"act$i$j\" class=\"collapse in\" >";
																		for($k = 0; $k < sizeof($data1); $k++)
																		{
																			echo "<li id=".$data1[$k][0]." class=\"mat\" >
																						<span class=\"selected-record\" data-type=\"material\"  ><span class=\"id\">".$data1[$k][0]."</span>"." - "."<span class=\"name\">".$data1[$k][1]."</span></span>";
																						
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
							<div id="inputTable" class="hidden" >  
								<form>
									<div class="col-sm-2" style="padding-top: 5px; padding-bottom: 5px" >
										<div class="col-xs-5 button" >
											<input class="btn btn-primary btn-xs" type="submit" name="save" value="Save">
										</div>
										
									</div>
								<?php
										if(isset($_SESSION['valid'])  &&  isset($_SESSION['userId']))// Condition for project and employee
										{
											$activity_data = fetchData($conn, "activity");
											$material_data = fetchData($conn, "material");
											$emp_pwbs_section = employeePwbsSectionFetch($conn, $pid, $_SESSION['userId']);  
											$emp_pwbs_activity = fetchEmployeePwbs($conn, "emp_project_activity", $_SESSION['userId'], $pid);  
											$emp_pwbs_material = fetchEmployeePwbs($conn, "emp_project_material", $_SESSION['userId'], $pid);									
												
											
											echo "<table id=\"table\" width=\"100%\" class=\"table table-hover table-striped table-expanded\" cellpadding=\"0\" cellspacing=\"0\" border=\"0\" style=\"padding: 0px;\"  >
													<thead>
														<tr class=\"info\">
														
															<th class=\"tcode\">
																M.Code
															</th>
															<th class=\"tname\">
																Name
															</th>
															<th class=\"tunit\">
																Unit
															</th>
															<th class=\"tquantity\">
																Quantity
															</th>
															<th class=\"tremark\">
																Remark
															</th>
														<tr>
													</thead>
													<tbody>          
														";
												for($i = 0; $i < sizeof($emp_pwbs_section); $i++)
												{
														
											
													
													$data = displayData($activity_data, $emp_pwbs_activity, $emp_pwbs_section[$i][0]);
																		
														for($j = 0; $j <sizeof($data); $j++ )
														{
															
												
																$data1 = displayData($material_data, $emp_pwbs_material, $data[$j][0]);								
																
																	for($k = 0; $k < sizeof($data1); $k++)
																	{
																		
																		echo "<tr class=\"mat\"></td><td class=\"tcode\">".$data1[$k][0]."</td>
																		<td class=\"tname\">".$data1[$k][1]."</td>
																		<td class=\"tunit\"><input></td>
																		<td class=\"tquantity\"><input></td>
																		<td class=\"tremark\"><input></td></tr>";                                
																	}							
														}						
													
												}
											echo "</tbody>
										</table>";
										}	
									?>
								</form>
							</div>
                        </td>
                    </tr>

                </tbody>
            </table>  

</div>
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
 
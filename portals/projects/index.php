<?php
session_start();	
error_reporting(E_ALL);
ini_set('display_errors', 1);
?>
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
<script src="../js/cschema.js"></script>
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
<header>
  <?php include_once('../includes/header.php'); ?>
</header>
<table  width="100%" cellpadding="2" cellpadding="10" >
    <tr class="info"  >
        <td colspan="3" align="center" valign="middle" style="padding: 3px"   >
                Search: <input type="text" onkeyup="tableSearch(this, 'table')" placeholder="Search.." title="Type in a name" style="width: 30%; height: 22px">
        </td>
    </tr>
    <tr>
        <td colspan="2" height="20px" >
                
        </td>
    </tr>
</table>

<div class="col-sm-12">
  

<?php

	//if(isset($_SESSION['valid']) ) // Condition for project and employee
	{
		include_once('../process/_cschema-connect.php');
		include_once('../process/_functions.php');
	
	    $projects = fetchAllProject($conn);
   
		echo "<table id=\"table\" class=\"table-hover table-striped link-list table-expanded\" width=\"100%\" cellpadding=\"0\" cellspacing=\"0\" border=\"0\" >
                
                <thead>
                    <tr class=\"info\">
                        <th valign=\"top\" >Id</th>
                        <th>Name</th>
                        <th>Nationality</th>
                        <th>Industry</th>                      
                        <th>Controller</th>
                        <th>Project's docs</th>
                        <th>Confirm date</th>
                        <th>Close date</th>                     
                        <th>Status</th>
                    </tr>
                </thead>
                <tbody>";
                    for($i=0; $i < sizeof($projects); $i++)
                    {
                        echo "<tr>
                                <td>".$projects[$i][0]."</td>
                                <td><a class=\"menu-link\" href=\"project.php?pid=".$projects[$i][0]."\">".$projects[$i][1]."</td>
                                <td>".$projects[$i][2]."</td>
                                <td>".$projects[$i][4]."</td>                                
                                <td><a href=\"mailto:".$projects[$i][11]."\">".$projects[$i][9]." ".$projects[$i][10]."</a></td>
                                <td>".$projects[$i][12]."</td>
                                <td>".$projects[$i][13]."</td>                                
                                <td>".$projects[$i][14]."</td>                   
                               <td>".$status = ($projects[$i][16]== 0)? 'Open': 'Closed' ."</td>


                            </tr>";
                    }
            echo "</tbody>
        </table>";
	}	
?>

</div>
<div class="panel-footer">
	<div class="container">					
		<p class="text-center">&copy; 2017 QsCompanion.</p>
	</div>
</div>
</body>
</html>
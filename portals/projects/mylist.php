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

	if(isset($_SESSION['valid']) ) // Condition for project and employee
	{
		include_once('../process/_cschema-connect.php');
		include_once('../process/_functions.php');
        $_SESSION["userId"]; 
        
	    $myProjects = fetchEmployeeProject($conn, $_SESSION["userId"]);
        
   
		echo "<table id=\"table\" class=\"table-hover table-striped link-list table-expanded\" width=\"100%\" cellpadding=\"0\" cellspacing=\"0\" border=\"0\" >
                
                <thead>
                    <tr class=\"info\">
                        <th valign=\"top\" >Id</th>
                        <th>Name</th>
                        <th>Nationality</th>
                        <th>Industry</th>                      
                        <th>Controller</th>
                        <th>Project's docs</th>
                        <th>End date</th>
                        <th>Close date</th>                     
                        <th>Status</th>
                    </tr>
                </thead>
                <tbody>";
                    for($i=0; $i < sizeof($myProjects); $i++)
                    {
                        echo "<tr>
                                <td>".$myProjects[$i][0]."</td>
                                <td><a class=\"menu-link\" href=\"myscope.php?pid=".$myProjects[$i][0]."\">".$myProjects[$i][1]."</td>
                                <td>".$myProjects[$i][2]."</td>
                                <td>".$myProjects[$i][3]."</td>                                
                                <td><a href=\"mailto:".$myProjects[$i][7]."\">".$myProjects[$i][5]." ".$myProjects[$i][6]."</a></td>
                                <td>".$myProjects[$i][8]."</td>
                                <td>".$myProjects[$i][9]."</td>                                
                                <td>".$myProjects[$i][10]."</td>                   
                               <td>".$status = ($myProjects[$i][12]== 0)? 'Open': 'Closed' ."</td>


                            </tr>";
                    }
            echo "</tbody>
        </table>";
	}
    else
    header('Location: /login.php');
   

?>

</div>
<script>
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
</script>
<div class="panel-footer">
	<div class="container">					
		<p class="text-center">&copy; 2017 QsCompanion.</p>
	</div>
</div>
</body>
</html>
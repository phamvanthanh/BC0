<?php
$data = json_decode(file_get_contents("php://input"));
$transaction = mysql_real_escape_string($data->tCode);
$node = mysql_real_escape_string($data->node);
$parentNode = mysql_real_escape_string($data->parentNode);
$restriction = mysql_real_escape_string($data->restriction);

mysql_connect("localhost", "root", "saunau")  or die(mysql_error());
mysql_select_db("erp") or die(mysql_error());

mysql_query("INSERT INTO transactionsetup(`tCode`,`node`, `parentNode`, `restriction`  ) VALUES('".$tCode."','".$node."','".$parentNode."', '".$restriction."')");

Print "Your information has been successfully added to the database."; 
?>

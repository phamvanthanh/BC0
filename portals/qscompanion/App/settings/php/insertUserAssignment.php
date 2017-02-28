<?php
$data = json_decode(file_get_contents("php://input"));
$uid = mysql_real_escape_string($data->uid);
$node = mysql_real_escape_string($data->node);

mysql_connect("localhost", "root", "saunau")  or die(mysql_error());
mysql_select_db("erp") or die(mysql_error());

mysql_query("INSERT INTO userassignment (`uid`, `node` ) VALUES('".$uid."','".$node."')");

?>

<?php
$data = json_decode(file_get_contents("php://input"));
$code = mysql_real_escape_string($data->code);
$name = mysql_real_escape_string($data->name);

mysql_connect("localhost", "root", "saunau")  or die(mysql_error());
mysql_select_db("erp") or die(mysql_error());

mysql_query("INSERT INTO node(`code`, `name` ) VALUES('".$code."','".$name."')");

Print "Your information has been successfully added to the database."; 
?>

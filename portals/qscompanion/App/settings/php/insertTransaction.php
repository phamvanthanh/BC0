<?php
$data = json_decode(file_get_contents("php://input"));
$code = mysql_real_escape_string($data->code);
$name = mysql_real_escape_string($data->name);
$stream = mysql_real_escape_string($data->stream);


mysql_connect("localhost", "root", "saunau")  or die(mysql_error());
mysql_select_db("erp") or die(mysql_error());

mysql_query("INSERT INTO transaction (`code`, `name`, `stream`) VALUES('".$code."','".$name."','".$stream."')");

Print "Your information has been successfully added to the database."; 
?>

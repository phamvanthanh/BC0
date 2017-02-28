<?php
$data = json_decode(file_get_contents("php://input"));
$code = mysql_real_escape_string($data->code);
$description = mysql_real_escape_string($data->description);

mysql_connect("localhost", "root", "saunau")  or die(mysql_error());
mysql_select_db("erp") or die(mysql_error());

mysql_query("INSERT INTO noderestriction (`code`, `description` ) VALUES('".$code."','".$description."')");

Print "Your information has been successfully added to the database."; 
?>

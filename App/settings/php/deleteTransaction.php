<?php
$data = json_decode(file_get_contents("php://input"));
$code = mysql_real_escape_string($data->code);
$name = mysql_real_escape_string($data->name);


mysql_connect("localhost", "root", "saunau")  or die(mysql_error());
mysql_select_db("erp") or die(mysql_error());

mysql_query("DELETE FROM transaction WHERE code = '$code'");

echo "Deletion is successfull."; 
?>

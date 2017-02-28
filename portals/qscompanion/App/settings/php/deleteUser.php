<?php
$data = json_decode(file_get_contents("php://input"));
$uid = mysql_real_escape_string($data->uid);

mysql_connect("localhost", "root", "saunau")  or die(mysql_error());
mysql_select_db("erp") or die(mysql_error());

mysql_query("DELETE FROM user WHERE uid = '$uid'");

echo "Deletion is successfull."; 
?>

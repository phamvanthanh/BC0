<?php
$data = json_decode(file_get_contents("php://input"));
$uid = mysql_real_escape_string($data->uid);
include_once('_erp-connect.php');
mysql_connect("localhost", "root", "saunau")  or die(mysql_error());
mysql_select_db("erp") or die(mysql_error());

mysql_query("DELETE FROM userassignment WHERE uid = '$uid'");

echo "Deletion is successfull."; 
?>

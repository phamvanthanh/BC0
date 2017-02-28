<?php
$data = json_decode(file_get_contents("php://input"));
$transaction = mysql_real_escape_string($data->transaction);

mysql_connect("localhost", "root", "saunau")  or die(mysql_error());
mysql_select_db("erp") or die(mysql_error());

mysql_query("DELETE FROM transactionSetup WHERE transaction = '$transaction'");

echo "Deletion is successfull."; 
?>

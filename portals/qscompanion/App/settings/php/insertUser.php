<?php
$data = json_decode(file_get_contents("php://input"));

$uid = mysql_real_escape_string($data->uid);
$email = mysql_real_escape_string($data->email);
$password = mysql_real_escape_string($data->password);
$name = mysql_real_escape_string($data->name);
$title = mysql_real_escape_string($data->title);
$dateOfBirth = mysql_real_escape_string($data->dateOfBirth);
$address = mysql_real_escape_string($data->address);
$city = mysql_real_escape_string($data->city);
$phone = mysql_real_escape_string($data->phone);
$homePhone = mysql_real_escape_string($data->homePhone);

mysql_connect("localhost", "root", "saunau")  or die(mysql_error());
mysql_select_db("erp") or die(mysql_error());

mysql_query("INSERT INTO user(`uid`, `email`, `password`, `name`, `title`, `dateOfBirth`, `address`, `city`, `phone`, `homePhone`) 
VALUES('".$uid."','".$email."','".$password."', '".$name."','".$title."','".$dateOfBirth."','".$address."','".$city."','".$phone."','".$homePhone."')");


?>

<?php
$content = file_get_contents("php://input");
$data = json_decode($content, true);

$con = mysqli_connect("localhost", "root", "saunau", "erp") or die("Connection is not establised.");

$code = mysqli_real_escape_string($con, $data['code']);
$name = mysqli_real_escape_string($con, $data['name']);


$query = mysqli_query($con, "INSERT INTO element (code, name ) VALUES('$code','$name')");


if (!$query)
{
  echo("Error description: " . mysqli_error($con));
}




?>

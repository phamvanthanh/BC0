<?php

header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");

include_once('_erp-connect.php');
$sql = "SELECT * FROM userassignment";
$result = ($conn->query($sql))? $conn->query($sql) : $conn->error;
$returned_array = [];

if($result->num_rows > 0)
{
	while($rs = $result->fetch_assoc()) {
	$row_array['uid'] = $rs['uid'];
	$row_array['node'] = $rs['node'];
	array_push($returned_array, $row_array);
	}
}
$conn->close();
echo json_encode($returned_array);
?>


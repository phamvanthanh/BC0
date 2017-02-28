<?php

header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");

include_once('_erp-connect.php');
$sql = "SELECT * FROM node";
$result = $conn->query($sql); 
$returned_array = [];
if($result->num_rows > 0)
{
	while($rs = $result->fetch_assoc()) {
		$row_array['code'] = $rs['code'];
		$row_array['name'] = $rs['name'];
		$row_array['description'] = $rs['description'];
		array_push($returned_array, $row_array);
	}
}
$conn->close();
echo json_encode($returned_array);
?>


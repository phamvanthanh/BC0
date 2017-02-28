<?php

header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");
include_once('_erp-connect.php');
$sql = "SELECT * FROM user";
$result = $conn->query($sql);
$returned_array = [];
if($result->num_rows > 0)
{ 
	while($rs = $result->fetch_assoc()) 
	{
		$row_array['uid'] = $rs['uid'];	
		$row_array['email'] = $rs['email'];
		$row_array['name'] = $rs['name'];
		$row_array['title'] = $rs['title'];
		$row_array['dateOfBirth'] = $rs['dateOfBirth'];
		$row_array['address'] = $rs['address'];
		$row_array['city'] = $rs['city'];
		$row_array['phone'] = $rs['phone'];
		$row_array['homePhone'] = $rs['homePhone'];
		array_push($returned_array, $row_array);
	}
}
$conn->close();
echo json_encode($returned_array);
?>


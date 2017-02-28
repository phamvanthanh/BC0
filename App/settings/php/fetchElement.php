<?php

date_default_timezone_set("Asia/Bangkok");
session_start();

include_once('_erp-connect.php');
$sql = "SELECT * FROM element";
$result = $conn->query($sql);
$returned_array = [];
if($result->num_rows > 0)
{
	while($rs = $result->fetch_assoc()) {
		$row_array['code'] = $rs['code'];
		$row_array['name'] = $rs['name'];
		array_push($returned_array, $row_array);
	}
}
$conn->close();
echo json_encode($returned_array);
?>


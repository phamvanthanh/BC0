<?php
/*date_default_timezone_set("Asia/Bangkok");
session_start();*/
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");


include_once('_erp-connect.php');
$sql = "SELECT * FROM transaction";
$result = $conn->query($sql); 
$returned_array = [];

if($result->num_rows > 0)
{
	while($rs = $result->fetch_assoc()) {
		$row_array['code'] = $rs['code'];
		$row_array['name'] = $rs['name'];
		$row_array['stream'] = $rs['stream'];
		$row_array['restriction'] = $rs['restriction'];
		array_push($returned_array, $row_array);
	}
}
$conn->close();
echo json_encode($returned_array);
?>


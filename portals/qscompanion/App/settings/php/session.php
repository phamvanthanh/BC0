<?php
date_default_timezone_set("Asia/Bangkok");
session_start();
if(isset($_SESSION['response'])){
	echo json_encode($_SESSION['response']); exit;
} else{
	echo "-1"; exit;
}

?>


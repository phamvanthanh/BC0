<?php
session_start();
date_default_timezone_set("Asia/Bangkok");
$data = json_decode(file_get_contents("php://input"), true);
$con=mysqli_connect("localhost","root","saunau","erp") or die("Connection is not established.");
$email = mysqli_real_escape_string($con, $data['email']);
$password = mysqli_real_escape_string($con, $data['password']);
$query = mysqli_query($con,"SELECT email, password FROM user WHERE email = '$email'");
$numrow = mysqli_num_rows($query);
$response = [];
	if ($numrow > 0){		
		while($rows = mysqli_fetch_array($query)){
			$dbemail = $rows['email'];
			$dbpassword = $rows['password'];			
			if ( $password == $dbpassword) {
				
					$response['islogin'] = true;
					$response['msg'] = $dbemail;				  	
					$_SESSION['response'] = $response;					
					echo json_encode($response); exit();
					
			} else {
				$response['islogin'] = false;
				$response['msg'] = "Password is not correct.";
				echo json_encode($response); exit();
			}	
		}			
	} else {
			$response['islogin'] = false;
			$response['msg'] = "Uid is not correct.";
			echo json_encode($response); exit();
	}
	$con->close();
?>

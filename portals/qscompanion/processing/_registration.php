<?php

include_once('connect.php');

function sentMessage(){

	header('Location: /thank-you.php');
}; 	
function sendError($err){

	echo "Your message is not sent, <br/>
	      Error:" .$err;
}; 

$user = $_POST;
unset($user["submit2"]);

$sql = "SELECT email FROM user WHERE email='".$user["email"]."'"; // WHERE email='".$lead["email"]."'

$result = $conn->query($sql);


if($result->num_rows > 0) // If lead registered 
{
	sentMessage();
}
			//New lead
else 
{
	$sql = "INSERT INTO user(firstName, lastName, email, password, phone, organization, education) VALUES ('".$user["firstName"]."', '".$user["lastName"]."', '".$user["email"]."', '123456', '".$user["phone"]."', '".$user["organization"]."', '".$user["education"]."')";

	if ($conn->query($sql) === TRUE) 
		sentMessage();
	else
		sendError($conn->error);

}
?>



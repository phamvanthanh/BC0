<?php
/*
$lead = array("firstName"=>$_POST["firstName"], 
	      	"lastName"=>$_POST["lastName"], 
              	"email"=>$_POST["email"],
	      	"phone"=>$_POST["phone"],
		"companyName"=>$_POST["companyName"],
		"industry"=>$_POST["industry"],
		"message"=>$_POST["message"]); 

echo $lead["firstName]; 

*/

function sentMessage(){

	header('Location: /thank-you.php');
}; 	
function sendError($err){

	echo "Your message is not sent, <br/>
	      Error:" .$err;
}; 

include_once('includes/header.php')

$lead = $_POST;
unset($lead["submit2"]);

$sql = "SELECT id FROM lead WHERE email='".$lead["email"]."'"; // WHERE email='".$lead["email"]."'

$result = $conn->query($sql);


if($result->num_rows > 0) // If lead registered 
{
	while($row = $result->fetch_assoc())
	{
		$existLeadId = $row["id"];
	}
		
	$sql = "INSERT INTO leadMessage(leadId, industry, message) VALUES ('".$existLeadId."', '".$lead["industry"]."', '".$lead["message"]."') ";
	if ($conn->query($sql) === TRUE)
			sentMessage();
	else 
			sendError($conn->error);
}
			//New lead
else {
	$sql = "INSERT INTO lead(firstName, lastName, email, phone, companyName) VALUES ('".$lead["firstName"]."', '".$lead["lastName"]."', '".$lead["email"]."', '".$lead["phone"]."', '".$lead["companyName"]."')";

	if ($conn->query($sql) === TRUE) {
		$leadId = $conn->insert_id;
		$sql = "INSERT INTO leadMessage(leadId, industry, message) VALUES ('".$leadId."', '".$lead["industry"]."', '".$lead["message"]."')";
		if ($conn->query($sql) === TRUE)
			sentMessage();
		else
			sendError($conn->error);	
    		
	}
	else
		 sendError($conn->error);

}
?>



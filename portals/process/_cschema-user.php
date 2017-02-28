<?php
error_reporting(E_ALL);
ini_set('display_errors', 1);

include_once('cschema-connect.php');


if (isset($_POST['login']) && !empty($_POST['email']) && !empty($_POST['password'])) {

	$user = $_POST;
	unset($user["login"]);

	$sql = "SELECT id, firstName, lastName, email, password FROM user WHERE email='".$user["email"]."'"; 

	$result = $conn->query($sql);

	if($result->num_rows > 0)
	{
		while($row = $result->fetch_assoc())
		{
			$password = $row["password"];
			/* processing password*/	
		}
		if($password == $user["password"])
		{
			  
			$_SESSION['valid'] = true;
        	$_SESSION['timeout'] = time();
        	$_SESSION['username'] = $user["firstName"]." ".$user["lastName"];	 
			header('Location: index.php');
		}
		else 
			echo "Password is incorrect";	
	

	}

	else echo "Email is incorrect";


}
else echo "Please input login information";
 
?>



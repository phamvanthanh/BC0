
<?php
	session_start();
	error_reporting(E_ALL);
	ini_set('display_errors', 1);

	
	include_once('_cschema-connect.php');
	if(isset($_SESSION["valid"]))
	{
		switch($_SESSION["class"])
		{
			case 0:
			case 1:
				header('Location: ../manage/index.php');
				break;
			case 2:
				header('Location: ../projects/index.php');
				break;
			default:
				break;
		}

	}
	
	else if (isset($_POST['login']) && !empty($_POST['email']) && !empty($_POST['password'])) 
	{

		$user = $_POST;
		unset($user["login"]);

		$sql = "SELECT id, firstName, lastName, email, password, class FROM user WHERE email='".$user["email"]."'"; 

		$result = $conn->query($sql);

		if($result->num_rows > 0)
		{
			while($row = $result->fetch_assoc())
			{
				$password = $row["password"];

				if($password == $user["password"])
				{
					
					$_SESSION["valid"] = true;
					$_SESSION["userId"] = (int)$row["id"];
					$_SESSION["class"] = (int)$row["class"];					
					$_SESSION["username"] = $row["firstName"]." ".$row["lastName"];	 					
					
					switch($_SESSION["class"])
					{
						case 0:
						case 1:
							header('Location: ../manage/index.php');
							break;
						case 2:
							header('Location: ../projects/index.php');
							break;
						default:
							break;
					}
					
				}
				else 
					echo "Password is incorrect";
			}
			
		}
		else echo "Email is incorrect";
	}
	else echo "Please input login information";
	
?>

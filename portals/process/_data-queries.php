<?php
session_start();
error_reporting(E_ALL);
ini_set('display_errors', 1);

include_once('_functions.php');


/*******************Section 1******************/
// Check login validation
// check for user's id, class 
$valid = isset($_SESSION["valid"]);
if($valid)
{
	$userClass = $_SESSION["class"];
	$userId = $_SESSION["userId"];
}

/*******************Section 2*****************/ 
//Insert, modify function
//1. Check for submit 
//2. Check for data type
//3. Convert data type to match database


if($valid)  
{
	include_once('_cschema-connect.php'); // Logged, connect the database
}
else 									  // Go to notice for further processing 
	header('Location: notice.php');

if(isset($_POST['save']) || isset($_POST['delete']) || isset($_POST['query'])) // Check for user's submit, if yes, save datatype ( industry, section, trade or material)
{
	$data = (string)$_POST['data'];
	
}
else // Else, move to notice.php if browse resolves to this processing php
{
	$_SESSION['error'] = "Save button is not clicked.";
	unset($data);
	header('Location: ../notice.php');
}
//var_dump($_POST);	

if(isset($data)) // if user submitted, check for submit data and save to appropriate table.
{
	switch ($data){
		case "industry":
			hieRecord($conn, $_POST, "industry");
			break;
		case "section":
			hieRecord($conn, $_POST, "section", "industry_section");
			break;
		case "activity":
			hieRecord($conn, $_POST, "activity", "section_activity");
			break;
		case "material":
			hieRecord($conn, $_POST, "material", "activity_material");
			break;
		case "project":
			projectRecord($conn, $_POST, "project");		
			break;
		case "project_employee":
			projectEmployee($conn, $_POST);					
			break;
		case "pwbs":
			{
				if($_POST['query'] == 'add')
					InsertWbs($conn, $_POST);
				else if($_POST['query'] == 'remove')
					removeWbs($conn, $_POST);
				else if($_POST['query'] == 'project')
				{
					$_SESSION['projectId'] = $_POST['project'];
					$_SESSION['employeeId'] = null;
				}
					
				else if($_POST['query'] == 'project_employee')
					$_SESSION['employeeId'] = $_POST['project_employee'];
					
			}	
			break;
		
		case "qto":
			{
				
				if($_POST['query'] == 'project')
				{
					$_SESSION['projectId'] = $_POST['project'];
					$_SESSION['employeeId'] = null;
				}
					
				else if($_POST['query'] == 'project_employee')
					$_SESSION['employeeId'] = $_POST['project_employee'];
					
			}	
			break;
		

		case "pwbs_employee":
			{
				if($_POST['query'] == 'add')
					insertPwbsEmployee($conn, $_POST);
				else if($_POST['query'] == 'remove')
					removePwbsEmployee($conn, $_POST);
			}		
			break;

		case "employee":
			{
				if($_POST['query'] == 'update')
					//var_dump($_POST);
					updateUser($conn, $_POST);
				else if($_POST['query'] == 'add')
					//var_dump($_POST);
					addUser($conn, $_POST);
				else if($_POST['query'] == 'delete')
					deleteUser($conn, $_POST);
				
			}		
			break;

		case "item":
			{		
				$item = new wbsItem_($conn, $_POST);
				switch($_POST['query'])
				{
					case 'fetch_level':
						echo $item->fetchLevel();
						break;
					case 'add':
						$item->insertItem();
						break;
					case 'update':
						$item->updateItem();
						break;
					case 'delete':
						$item->deleteItem();
						break;
					default:
						break;


				}
			
				
			}		
			break;

		case "gwbs":
			{	
				$item = new gwbs_($conn, $_POST);
		
				switch($_POST['query'])	
				{
					case 'add':
						$item->insertItem();
						break;
					case 'delete':
						$item->deleteItem();
						break;
					case 'update':
					
						$item->UpdateItem();
						break;



				}
			}
			break;
		
		
		default:		
			$_SESSION['error'] = "WBS is not specified.";
			header('Location: ../notice.php');
			break;

	}
}




?>

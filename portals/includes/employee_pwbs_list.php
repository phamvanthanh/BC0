<?php
	session_start();
	error_reporting(E_ALL);
	ini_set('display_errors', 1);
	
	if(isset($_SESSION['valid']) && isset($_SESSION['projectId']) && isset($_SESSION['employeeId'])) // Condition for project and employee
	{
		include_once('../process/_cschema-connect.php');
		include_once('../process/_functions.php');
	
	
		$activity_data = fetchData($conn, "activity");
		$material_data = fetchData($conn, "material");
		$emp_pwbs_section = employeePwbsSectionFetch($conn, $_SESSION['projectId'], $_SESSION['employeeId']);  
		$emp_pwbs_activity = fetchEmployeePwbs($conn, "emp_project_activity", $_SESSION['employeeId'], $_SESSION['projectId']);  
		$emp_pwbs_material = fetchEmployeePwbs($conn, "emp_project_material", $_SESSION['employeeId'], $_SESSION['projectId']);  	
		
		
		echo "<ul  >";
			for($i = 0; $i < sizeof($emp_pwbs_section); $i++)
			{
		
				
					echo "<li id=".$emp_pwbs_section[$i][0]." class=\"sec\" >";
					echo "<span class=\"selected-record\" data-type=\"section\" ><span class=\"id\">".$emp_pwbs_section[$i][0]."</span>"." - "."<span class=\"name\">".$emp_pwbs_section[$i][1]."</span></span>";
					
					$data = displayData($activity_data, $emp_pwbs_activity, $emp_pwbs_section[$i][0]);
					
					echo "<ul id=\"sec$i\" class=\"collapse in\" >";
						for($j = 0; $j <sizeof($data); $j++ )
						{
							echo "<li id=".$data[$j][0]." class=\"act\" >";
								echo "<span class=\"selected-record\" data-type=\"activity\"  ><span class=\"id\">".$data[$j][0]."</span>"." - "."<span class=\"name\">".$data[$j][1]."</span></span>";
								$data1 = displayData($material_data, $emp_pwbs_material, $data[$j][0]);								
								echo "<ul id=\"act$i$j\" class=\"collapse in\" >";
										for($k = 0; $k < sizeof($data1); $k++)
										{
											echo "<li id=".$data1[$k][0]." class=\"mat\" >
														<span class=\"selected-record\" data-type=\"material\"  ><span class=\"id\">".$data1[$k][0]."</span>"." - "."<span class=\"name\">".$data1[$k][1]."</span></span>";
														
											echo "</li>";
										}
								echo "</ul>";

							echo "</li>";
						}
					echo "</ul>";
					
				echo "</li>";
			}
		echo "</ul>";
	}	
?>

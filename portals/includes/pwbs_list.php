<div id="pwbs" >
<span>Select items to remove from the project.</span>
<?php
	session_start();
	error_reporting(E_ALL);
	ini_set('display_errors', 1);
	

	
	if(isset($_SESSION['valid']) && isset($_SESSION['projectId']))
	{
		include_once('../process/_cschema-connect.php');
		include_once('../process/_functions.php');
		
		$activity_data = fetchData($conn, "activity");
		$material_data = fetchData($conn, "material");
	
		$project_section_data = projectSectionFetch($conn, $_SESSION['projectId']);
		$project_activity_data = fetchProjectFK($conn, "project_activity", $_SESSION['projectId']);
		$project_material_data = fetchProjectFK($conn, "project_material", $_SESSION['projectId']);
		//var_dump($project_activity_data);
		echo "<ul  >";
			for($i = 0; $i < sizeof($project_section_data); $i++)
			{
				
					echo "<li id=".$project_section_data[$i][0]." class=\"sec\" >";
					echo "<span class=\"selected-record\" data-type=\"section\" ><span class=\"id\">".$project_section_data[$i][0]."</span>"." - "."<span class=\"name\">".$project_section_data[$i][1]."</span></span>";
					
					$data2 = displayData($activity_data, $project_activity_data, $project_section_data[$i][0]);
					//var_dump($data2);
					echo "<ul id=\"sec$i\" class=\"collapse in\" >";
						for($j = 0; $j <sizeof($data2); $j++ )
						{
							echo "<li id=".$project_activity_data[$i][0]." class=\"act\" >";
								echo "<span class=\"selected-record\" data-type=\"activity\"  ><span class=\"id\">".$data2[$j][0]."</span>"." - "."<span class=\"name\">".$data2[$j][1]."</span></span>";
								$data3 = displayData($material_data, $project_material_data, $data2[$j][0]);								
								echo "<ul id=\"act$i$j\" class=\"collapse in\" >";
										for($k = 0; $k < sizeof($data3); $k++)
										{
											echo "<li id=".$material_data[$k][0]." class=\"mat\" >
														<span class=\"selected-record\" data-type=\"material\"  ><span class=\"id\">".$data3[$k][0]."</span>"." - "."<span class=\"name\">".$data3[$k][1]."</span></span>";
														
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
</div>

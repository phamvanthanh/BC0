<br/>
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
		
		
		echo "<table id=\"table\" class=\"table table-hover table-striped table-expanded\" cellpadding=\"0\" cellspacing=\"0\" border=\"0\" style=\"padding: 0px;\"  >
                <thead>
                    <tr class=\"info\">
                       
                        <th class=\"tcode\">
                            M.Code
                        </th>
                        <th class=\"tname\">
                            Name
                        </th>
                        <th class=\"tunit\">
                            Unit
                        </th>
                         <th class=\"tquantity\">
                            Quantity
                        </th>
                        <th class=\"tremark\">
                            Remark
                        </th>
                    <tr>
                </thead>
                <tbody>          
                    ";
			for($i = 0; $i < sizeof($emp_pwbs_section); $i++)
			{
					
               // echo "<tr class=\"sec\"><td class=\"tcode\">".$emp_pwbs_section[$i][0]."</td><td class=\"tcode\"></td><td class=\"tcode\"></td><td class=\"tname\">".$emp_pwbs_section[$i][1]."</td><td class=\"tunit\"></td><td class=\"tquantity\"></td><td class=\"tremark\"></td></tr>";
                
                $data = displayData($activity_data, $emp_pwbs_activity, $emp_pwbs_section[$i][0]);
                                    
                    for($j = 0; $j <sizeof($data); $j++ )
                    {
                        
               //         echo "<tr class=\"act\"><td class=\"tcode\"></td><td class=\"tcode\">".$data[$j][0]."</td><td class=\"tcode\"></td><td class=\"tname\">".$data[$j][1]."</td><td class=\"tunit\"></td><td class=\"tquantity\"></td><td class=\"tremark\"></td></tr>";
                            $data1 = displayData($material_data, $emp_pwbs_material, $data[$j][0]);								
                            
                                for($k = 0; $k < sizeof($data1); $k++)
                                {
                                    
                                    echo "<tr class=\"mat\"></td><td class=\"tcode\">".$data1[$k][0]."</td>
                                    <td class=\"tname\">".$data1[$k][1]."</td>
                                    <td class=\"tunit\"><input></td>
                                    <td class=\"tquantity\"><input></td>
                                    <td class=\"tremark\"><input></td></tr>";                                
                                }							
                    }						
				
			}
		echo "</tbody>
    </table>";
	}	
?>

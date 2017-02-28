
<?php
    session_start();
    error_reporting(E_ALL);
    ini_set('display_errors', 1);
    
    if(isset($_SESSION['valid']))
    {
        include_once('../process/_cschema-connect.php');
        include_once('../process/_functions.php');
            
        $project_employee_data = fetchProjectEmployee($conn);   
        
        echo "<table id=\"table\" class=\"table table-striped table-bordered table-condensed table-hover\">
                    <tr class=\"info\">
                        
                        <th class=\"item_no\">No</th>
                        <th class=\"item_code\">Project Id</th>
                        <th class=\"item_name\">Project Name</th>
                        <th class=\"item_desc\">Employee Id</th>
                        <th class=\"item_desc\">Employee Name</th>
                        <th class=\"item_desc\">Email</th>
                        <th class=\"item_desc\">Phone</th>
                    </tr>
                    <tbody>";

                        for($i = 0; $i < sizeof($project_employee_data); $i++)
                        {
                            
                        echo "<tr> 
                                <td>".($i+1)."</td>
                                <td><span class=\"hidden\">".$project_employee_data[$i][0]."</span><a class=\"edit-row\" href=\"#divdash=pteam_display&divlist=project_employee_list&divform=pteam_form\" >".$project_employee_data[$i][0]."</td>
                                <td class=\"hidden\"><span>".$project_employee_data[$i][2]."</span>".$project_employee_data[$i][2]."</td>
                                <td><span class=\"hidden\">".$project_employee_data[$i][1]." </span>".$project_employee_data[$i][1]."</td>
                                <td><span class=\"hidden\">".$project_employee_data[$i][2]."</span>".$project_employee_data[$i][2]."</td>
                                <td><span class=\"hidden\">".$project_employee_data[$i][3]."</span>".$project_employee_data[$i][3]." ".$project_employee_data[$i][4]."</td>
                                <td><span class=\"hidden\">".$project_employee_data[$i][5]."</span>".$project_employee_data[$i][5]."</td>
                                <td><span class=\"hidden\">".$project_employee_data[$i][6]."</span>".$project_employee_data[$i][6]."</td>
                            </tr>";								
                        }
            echo "</tbody>
        </table>";	
        
        
    }
    else
    {					
        $_SESSION['error'] = "industry_display says: Session expired";
        header('Location: ../notice.php');
    }
        

?>

	


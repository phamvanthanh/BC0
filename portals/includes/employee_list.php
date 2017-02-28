<div class="panel panel-default">
    <div class="panel-heading">
        Employee records
    </div>
    <div class="panel-body">
        
        <div id="tableDiv" class="table-responsive">	
        <?php
            session_start();
            error_reporting(E_ALL);
            ini_set('display_errors', 1);
            
            if(isset($_SESSION['valid']))
            {
                include_once('../process/_cschema-connect.php');
                include_once('../process/_functions.php');
                
                $user_data = fetchAllUser($conn);                
                
                echo "<table id=\"table\" class=\"table table-striped table-bordered table-condensed table-hover\">
                            <tr class=\"info\">
                                <th class=\"item_no\">No</th>
                                <th class=\"item_code\">Id</th>
                                <th class=\"item_name\">Name</th>
                                <th class=\"item_desc\">Email</th>
                                <th class=\"item_desc\">Phone</th>
                                <th class=\"item_desc\">Org.</th>
                                <th class=\"item_desc\">Edu.</th>
                                <th class=\"item_desc\">Col.</th>
                                <th class=\"item_desc\">Class.</th>
                                <th class=\"item_desc\">Stat.</th>
                            </tr>
                            <tbody>";

                                for($i = 0; $i < sizeof($user_data); $i++)
                                {
                                echo "<tr> 
                                        <td>".$i."</td>
                                        <td><span class=\"hidden\">".$user_data[$i][0]."</span><a class=\"edit-row\" href=\"#dash=employee_display&list=employee_list&form=employee_form\" >".$user_data[$i][0]."</a></td>
                                        <td><span class=\"hidden\">".$user_data[$i][1]."</span>".$user_data[$i][1]." ".$user_data[$i][2]."</td>
                                        <td class=\"hidden\"><span class=\"hidden\">".$user_data[$i][2]."</span></td>
                                        <td><span class=\"hidden\">".$user_data[$i][3]."</span>".$user_data[$i][3]."</td>
                                        <td><span class=\"hidden\">".$user_data[$i][4]."</span>".$user_data[$i][4]."</td>
                                        <td><span class=\"hidden\">".$user_data[$i][5]."</span>".$user_data[$i][5]."</td>
                                        <td><span class=\"hidden\">".$user_data[$i][6]."</span>";
                                             switch($user_data[$i][6]){
                                                case 0 :
                                                    echo "DS";
                                                    break;
                                                case 1 :
                                                    echo "BS";
                                                    break;
                                                case 2 :
                                                    echo "MS";
                                                    break;
                                                 case 3 :
                                                    echo "Ph.D";
                                                    break;
                                                 case 4 :
                                                    echo "Other";
                                                    break;
                                                default:
                                                    break;
                                            }
                                        echo "</td> 
                                        <td><span class=\"hidden\">".$user_data[$i][7]."</span>".$user_data[$i][7]."</td>                          
                                        <td><span class=\"hidden\">".$user_data[$i][8]."</span>";
                                             switch($user_data[$i][8]){
                                                case 0 :
                                                    echo "Super user";
                                                    break;
                                                case 1 :
                                                    echo "Power user";
                                                    break;
                                                case 2 :
                                                    echo "Employee";
                                                    break;
                                                default:
                                                    break;
                                            }
                                        echo "</td>
                                        <td><span class=\"hidden\">".$user_data[$i][9]."</span>"; 
                                            switch($user_data[$i][9]){
                                                case 0 :
                                                    echo "Deactivated";
                                                    break;
                                                case 1 :
                                                    echo "Activated";
                                                    break;                                              
                                                default:
                                                    break;
                                            }

                                       echo  "</td>                                                
                                     </tr>";						
                                
                                }
                    echo "</tbody>
                </table>";	               
                
            }
            else
            {
                $_SESSION['error'] = "industry_display says: Session expired";
                header('Location: notice.php');
            }	

        ?>
    </div>
</div>	
<script  type="text/javascript">
	
		var user_json = <?php echo json_encode($user_data); 	?>//JSON_FORCE_OBJECT
		var id_json = user_json.map(mapId);
		var email_json = user_json.map(mapEmail);
		console.log(user_json);
</script>

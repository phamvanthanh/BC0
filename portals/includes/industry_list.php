<div class="panel panel-default">
    <div class="panel-heading">
        Industry records
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
                    $industry_data = fetchData($conn, "industry");
                    		
                    
                    echo "<table id=\"table\" class=\"table table-striped table-bordered table-condensed table-hover\">
                                <tbody>
                                    <tr class=\"info\">
                                        <th class=\"item_no\">No</th>
                                        <th class=\"item_code\">Code</th>
                                        <th class=\"item_name\">Name</th>
                                        <th class=\"item_desc\">Description</th>
                                    </tr>
                                </tbody>
                                <tbody>";
                                    for($i = 0; $i < sizeof($industry_data); $i++)
                                    {
                                    echo "<tr> 
                                            <td>".($i+1)."</td>
                                            <td><span class=\"hidden\">".$industry_data[$i][0]."</span><a class=\"edit-row\" href=\"#divdash=industry_display&divlist=industry_list&divform=industry_form\" >".$industry_data[$i][0]."</td>
                                            <td><span class=\"hidden\">".$industry_data[$i][1]."</span>".$industry_data[$i][1]."</td>
                                            <td><span class=\"hidden\">".$industry_data[$i][2]."</span>".$industry_data[$i][2]."</td>
                                            </tr>";								
                                    }
                        echo "</tbody>
                    </table>";		
                    
                    
                }
                else
                {
                    $_SESSION['error'] = "industry_display says: Session expired";
                    header('Location: ./notice.php');
                }			

            ?>
        </div>
    </div>
</div><!-- End of list -->
<script  type="text/javascript">							
	var industry_json = <?php echo json_encode($industry_data); 	?>//JSON_FORCE_OBJECT
	var id_json = industry_json.map(mapId);
	var name_json = industry_json.map(mapName);
	
</script>
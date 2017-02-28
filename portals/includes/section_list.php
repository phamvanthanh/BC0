<div class="panel panel-default">
    <div class="panel-heading">
        Section records
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
                        $section_data = fetchData2($conn, "section", "industry_section");
                
                    
                    echo "<table id=\"table\" class=\"table table-striped table-bordered table-condensed table-hover\">
                                <tr class=\"info\">
                                    <th class=\"item_no\">No</th>
                                    <th class=\"item_code\">Code</th>
                                    <th class=\"item_name\">Name</th>
                                    <th class=\"item_desc\">Description</th>
                                    <th class=\"hidden\">Parents</th>
                                </tr>
                                <tbody>";

                                    for($i = 0; $i < sizeof($section_data); $i++)
                                    {
                                    echo "<tr> 
                                            <td>".$i."</td>
                                            <td><span class=\"hidden\">".$section_data[$i][0]."</span><a class=\"edit-row\" href=\"#divdash=section_display&divlist=section_list&divform=section_form\" >".$section_data[$i][0]."</a></td>
                                            <td><span class=\"hidden\">".$section_data[$i][1]."</span>".$section_data[$i][1]."</td>
                                            <td class=\"hidden\" ><span class=\"hidden\">".$section_data[$i][3]."</span></td>
                                            <td><span class=\"hidden\">".$section_data[$i][2]."</span>".$section_data[$i][2]."</td>                                            
                                            </tr>";								
                                    }
                        echo "</tbody>
                    </table>";	
                }
               // else
                {
                   // $_SESSION['error'] = "industry_display says: Session expired";
                   //header('Location: notice.php');
                }                    
            
            ?>	       
				
        </div>
    </div>	
    <script type="text/javascript">
       
           var section_json = <?php echo json_encode($section_data); 	?>//JSON_FORCE_OBJECT
        
            var id_json = section_json.map(mapId);
            var name_json = section_json.map(mapName);

     
    </script>			
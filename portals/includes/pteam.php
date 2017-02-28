
	<div class="col-sm-6">	
			<span>Select items to add to the project.</span><br/>
            <span class="search-input" ><input type="text" id="searchInput" onkeyup="listSearch()" placeholder="Search.." title="Type in a name"></span>
		
			<?php
				session_start();
				error_reporting(E_ALL);
				ini_set('display_errors', 1);
				
				if(isset($_SESSION['valid']) && isset($_SESSION['projectId']))
				{
					include_once('../process/_cschema-connect.php');
					include_once('../process/_functions.php');
				
					$user_data = fetchData($conn, "user");
				
					
					
                    echo "<table id=\"table\" class=\"table table-striped table-bordered table-condensed table-hover\">
                                <tr class=\"info\">
                                    <th class=\"item_no\">Opt</th>
                                    <th class=\"item_no\">No</th>
                                    <th class=\"item_code\">Id</th>
                                    <th class=\"item_name\">Name</th>
                                    <th class=\"item_desc\">Email</th>
                                    <th class=\"item_desc\">Phone</th>
                                    <th class=\"item_desc\">Org.</th>
                                    <th class=\"item_desc\">Class</th>
                                </tr>
                                <tbody>";

                                    for($i = 0; $i < sizeof($user_data); $i++)
                                    {
                                    echo "<tr> 
                                            <td><input type=\"checkbox\" ></td>
                                            <td>".($i+1)."</td>
                                            <td><span class=\"hidden\">".$user_data[$i][0]."</span><a class=\"edit-row\" href=\"#dash=project_display&list=project_list&form=project_form\" >".$user_data[$i][0]."</td>
                                            <td><span class=\"hidden\">".$user_data[$i][1]." ".$user_data[$i][2]."</span>".$user_data[$i][1]." ".$user_data[$i][2]."</td>
                                            <td><span class=\"hidden\">".$user_data[$i][3]."</span>".$user_data[$i][3]."</td>
                                            <td><span class=\"hidden\">".$user_data[$i][5]."</span>".$user_data[$i][5]."</td>
                                            <td><span class=\"hidden\">".$user_data[$i][6]."</span>".$user_data[$i][6]."</td>
                                            <td><span class=\"hidden\">".$user_data[$i][8]."</span>".$user_data[$i][8]."</td>
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
	
	
</div>
<div  class="col-sm-6"  >
    <span>Select items to remove from the project.</span><br/>
    <span class="search-input" ><input type="text" id="searchInput" onkeyup="listSearch()" placeholder="Search.." title="Type in a name"></span>
    <?php
       
             
        if(isset($_SESSION['valid']) && isset($_SESSION['projectId']))
        {
           
        
            $project_section_data = projectSectionFetch($conn, $_SESSION['projectId']);
            $project_activity_data = fetchProjectFK($conn, "project_activity", $_SESSION['projectId']);
            $project_material_data = fetchProjectFK($conn, "project_material", $_SESSION['projectId']);
       
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




  <script>
  
  
	 


	 var selectedProjectId = <?php echo $_SESSION['projectId'] ; ?>; 
	 if(typeof(selectedProjectId) != 'undefined' && selectedProjectId!= '' && selectedProjectId != null )
	 {
		 $('select[name*="project"]').children("option[value='" + selectedProjectId + "']").prop("selected", true);
		 //load("#pwbs", 'pwbs');

	 }

	  
  </script>
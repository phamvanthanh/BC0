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
    
            $section_activity_data = fetchData($conn, "section_activity");
            $activity_material_data = fetchData($conn, "activity_material");           

            $project_section_data = projectSectionFetch($conn, $_SESSION['projectId']);
            $project_activity_data = fetchProjectFK($conn, "project_activity", $_SESSION['projectId']);
            $project_material_data = fetchProjectFK($conn, "project_material", $_SESSION['projectId']);

    echo "<ul  >";
        for($i = 0; $i < sizeof($project_section_data); $i++)
        {
            
                echo "<li id=".$project_section_data[$i][0]." class=\"sec\" >";
                echo "<span class=\"record\" data-type=\"section\" ><span class=\"id\">".$project_section_data[$i][0]."</span>"." - "."<span class=\"name\">".$project_section_data[$i][1]."</span></span>";
                
                $data = displayData($activity_data, $project_activity_data, $project_section_data[$i][0]);
                //var_dump($data2);
                echo "<ul id=\"sec$i\" class=\"collapse in\" >";
                    for($j = 0; $j <sizeof($data); $j++ )
                    {
                        echo "<li id=".$data[$j][0]." class=\"act\" >";
                            echo "<span class=\"record\" data-type=\"activity\"  ><span class=\"id\">".$data[$j][0]."</span>"." - "."<span class=\"name\">".$data[$j][1]."</span></span>";
                            $data1 = displayData($material_data, $project_material_data, $data[$j][0]);								
                            echo "<ul id=\"act$i$j\" class=\"collapse in\" >";
                                for($k = 0; $k < sizeof($data1); $k++)
                                {
                                    echo "<li id=".$material_data[$k][0]." class=\"mat\" >
                                         <span class=\"record\" data-type=\"material\"  ><span class=\"id\">".$data1[$k][0]."</span>"." - "."<span class=\"name\">".$data1[$k][1]."</span></span>";
                                                
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





  <script>
  


	 var selectedProjectId = <?php echo $_SESSION['projectId'] ; ?>; 
	 if(typeof(selectedProjectId) != 'undefined' && selectedProjectId!= '' && selectedProjectId != null )
	 {
		 $('select[name*="project"]').children("option[value='" + selectedProjectId + "']").prop("selected", true);
		 //load("#pwbs", 'pwbs');

	 }

	  
  </script>
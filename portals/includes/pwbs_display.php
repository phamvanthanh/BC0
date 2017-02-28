<div class="panel panel-info" >
	<div class="panel-heading" >		
		<span  class="tree-title" >Project wbs</span>						
		<span class="search-input">					
				<select  name="project" class="smallInput" >						
						<option></option>
						<?php 																	
							session_start();
							error_reporting(E_ALL);
							ini_set('display_errors', 1);
							include_once('../process/_cschema-connect.php');
							$sql = "SELECT id, name FROM project WHERE status = 0";
							$result = $conn->query($sql);
							if($result->num_rows > 0)
							{									
								while($row = $result->fetch_assoc())
								{												
									echo "<option value=".$row['id'].">".$row['name']."</option>";												
								}					
							}							
						?>				
				</select>
		</span>	
	</div>
	<div id="divform" class="panel-body" >
			
	
	</div>
</div>

<script>
    var selectedProjectId = <?php echo json_encode($_SESSION['projectId']) ; ?>; 
    
	if(typeof(selectedProjectId) != 'undefined' && selectedProjectId!= '' && selectedProjectId != null )
	{
		$('select[name*="project"]').children("option[value='" + selectedProjectId + "']").prop("selected", true);
	}
  
</script>

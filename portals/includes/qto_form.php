<form class="inline-form" action="process/_data-queries.php" method="post" >
	<div class="col-sm-3">								
		<label for="input1" >Project:</label>
		<select  id="input1" name="project"  style="width: 70%; height: 22px;" >						
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
	</div>
	<div id="pwbs-emp" class="col-sm-3">		
		<script>
				$('#pwbs-emp').load("../includes/pwbs_emp.php");
		</script>		
	</div>		
</form>		
<script>
    var selectedProjectId = <?php echo json_encode($_SESSION['projectId']) ; ?>; 
   
	if(typeof(selectedProjectId) != 'undefined' && selectedProjectId!= '' && selectedProjectId != null )
	{
		$('select[name*="project"]').children("option[value='" + selectedProjectId + "']").prop("selected", true);
	}
  
</script>
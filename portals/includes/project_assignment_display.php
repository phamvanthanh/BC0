<div class="panel panel-info" >
	<div class="panel-heading" >
		<span class="tree-title" >Pwbs assignment</span>	
	</div>
	<div class="panel-body">
		<div class="col-sm-12 text-center" style="padding-bottom: 10px" >
			<form class="form-inline" action="" method="post" >			
				<div class="form-group">
					<input class="btn btn-default btn-xs smallInput form-control" type="button" name="add" value=">>">	
				</div>
				<div class="form-group">			
					<input class="btn btn-default btn-xs smallInput form-control"  type="button" name="remove" value="<<">	
				</div>
				<div class="form-group">
					<input class="btn btn-default btn-xs smallInput form-control" name="notify" value="Notify" style="width:50px" >
				</div>
				<div class="form-group">
					<input class="hidden" name="data" value="pwbs_employee">
				</div>
				
			</form>	
		</div>
		<div class="col-sm-6">
		
					<label for="project" >Project:</label>							
					<select id="project" name="project" style="width: 70%; height: 22px;"  >						
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
		
		<div id="divpwbs-emp-form" class="col-sm-6 text-left">
			<script>
				$('#divpwbs-emp-form').load("../includes/pwbs_emp.php");
			</script>
		</div>
		<div id="divform" class="col-sm-6 box" >
		</div>	
		
		<div id="divlist" class="col-sm-6 box" style="border-left: 1px" >
		</div>
	</div>
</div>
<script>
    var selectedProjectId = <?php echo json_encode($_SESSION['projectId']) ; ?>; 
   
	if(typeof(selectedProjectId) != 'undefined' && selectedProjectId!= '' && selectedProjectId != null )
	{
		$('select[name*="project"]').children("option[value='" + selectedProjectId + "']").prop("selected", true);
	}
  
</script>
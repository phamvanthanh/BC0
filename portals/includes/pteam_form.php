<div class="form panel panel-default"  id="sform">
	<div class="panel-heading">
		<span>Record inputs</span><span id="form-notice" class="pull-right"></span>
	</div>
	<div class="panel-body"> 
		<form class="long-form" action="" method="post" >
			<div class="form-group">
				<div class="form-label">
					Project: 
				</div>
				<div class="form-field">
                    <select type="text" name="projectId"  class="form-control single-select" >
                         <option></option>                       
                            <?php 			
                                                                            
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
			</div>
			<div class="form-group">
				<div class="form-label">
					Employee:
				</div>
				<div class="form-field">				
                    <select type="text" name="employeeId"  class="form-control single-select" >
                        <option></option>                       
                        <?php                                                                       
                                include_once('../process/_cschema-connect.php');
                                $sql = "SELECT id, firstName, lastName FROM user";
                                $result = $conn->query($sql);
                                if($result->num_rows > 0)
                                {									
                                    while($row = $result->fetch_assoc())
                                    {												
                                        echo "<option value=".$row['id'].">".$row['firstName']." ".$row['lastName']."</option>";												
                                    }					
                                }							
                        ?>
                    </select>
				</div>
			</div>	
			
			<!-- Hidden input -->
			<div class="form-group" style="visibility: hidden">				
				<div class="form-field">
					<input  name="data" value="project_employee">
				</div>
			</div>
			<div class="form-group">					
				<?php include_once('form_button.php'); ?>
			</div>
		</form>
	</div>

</div><!-- End of Form -->
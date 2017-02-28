<div class="form panel panel-default"  id="sform">
	<div class="panel-heading">
		<span>Record inputs</span><span id="form-notice" class="pull-right"></span>
	</div>
	<div class="panel-body"> 
		<form class="long-form" action='' method="post" >
			<div class="form-group">
				<div class="form-label">
					Code: 
				</div>
				<div class="form-field">
					<input type="text" name="id" placeholder="code" data-validated='false' onkeyup="checkExistingValue(this, id_json)" required >
				</div>
			</div>
			<div class="form-group">
				<div class="form-label">
					Name:
				</div>
				<div class="form-field">
					<input type="text" name="name" placeholder="section" data-validated='false' onkeyup="checkExistingValue(this, name_json)" required>
				</div>
			</div>
			<div  class="form-group">
				<div class="form-label">
					Parents:
				</div>
				<div class="form-field">
					<select id="parent-field" name="parents[]" multiple="multiple" class="form-control multiple">						
								<?php 			
																	
									include_once('../process/_cschema-connect.php');
									$sql = "SELECT id, name FROM section";
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
						<p class="vali-text"></p>
						<script type="text/javascript">
						$('select').select2();
					</script>
				</div>				
			</div>
			<div class="form-group">
				<div class="form-label">
					Description:
				</div>
				<div class="form-field">
					<textarea  name="description" placeholder=""></textarea>
				</div>
			</div>
			<!-- Hidden input -->			
			<div class="form-group" style="visibility: hidden">
				<div class="form-field">
					<input  name="data" value="activity">
				</div>
			</div>
			<div class="form-group">
			
				<?php include_once('form_button.php'); ?>
			</div>
			
		</form>
	</div>

</div> <!-- End of Form -->
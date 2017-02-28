<div class="form panel panel-default"  id="sform">
	<div class="panel-heading">
		<span>Record inputs</span><span id="form-notice" class="pull-right"></span>
	</div>
	<div class="panel-body"> 
		<form class="short-form" action='' method="post" >
			<div class="form-group">
				<div class="col-xs-6">
					<label>Record:</label> 
					<input type="text" name="id" class="form-control" placeholder="auto" readonly  >
				</div>
				<div class="col-xs-6">
					<label>Code: </label>
					<input type="text" name="code" class="form-control" placeholder="code"    >
				</div>
			</div>		
			<div class="form-group">
				<div class="col-xs-12">
					<label>Name:</label>
					<input type="text" name="name" class="form-control" placeholder="name"   >
				</div>
			
			</div>
			<div  class="form-group">
				<div class="col-xs-12">
					<label>Parent:</label>									
					<select id="parent-field" name="parent_code" class="form-control" onchange="getVal(this)" >						
								<option></option>
								<?php 			
																	
									include_once('../process/_cschema-connect.php');
									$sql = "SELECT code, name FROM wbs";
									$result = $conn->query($sql);
									if($result->num_rows > 0)
									{									
										while($row = $result->fetch_assoc())
										{												
											echo "<option value=".$row['code'].">".$row['code']." - ".$row['name']."</option>";												
										}					
									}							
								?>				
						</select>
					<script>
						selected('select[name="parent_code"]');
						
					</script>
						
				</div>
									
			</div>
			<div class="form-group">
				<div class="col-xs-12">
					<label>Description:</label>				
					<textarea  name="description" placeholder=""></textarea>
				</div>
			</div>
			<div class="form-group">
				<div class="col-xs-12">
					<label>Display:</label>		
					<span class="radio">
						<label class="radio-inline"><input  class="radio-input" type="radio" name="status" value='0' checked >Yes</label>
						<label class="radio-inline"><input  class="radio-input" type="radio" name="status" value='1' >No</label>
					</span>
				</div>
			</div>
		
			<!-- Hidden input -->			
			<div class="form-group" style="visibility: hidden">
				<div class="form-field">
					<input  name="data" value="item">
				</div>
			</div>
			<div class="form-group">			
				<?php include_once('form_button.php'); ?>
			</div>
		  </form>
	</div>

</div> <!-- End of Form -->
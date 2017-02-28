<?php 
	session_start();
	error_reporting(E_ALL);
	ini_set('display_errors', 1);
?>
<div class="form panel panel-default"  id="sform">
	<div class="panel-heading">
		<span>Record inputs</span><span id="form-notice" class="pull-right"></span>
	</div>
	<div class="panel-body"> 
		<form class="short-form" action="" method="post" >
			<div class="form-group">
				<div class="col-xs-4">
					<label>	Id:</label>			
					<input class="form-control" name="id" type="text"  placeholder="Auto"  readonly >
				</div>
				<div class="col-xs-8">
					<label>Name:</label>
					<input class="form-control" type="text" name="name" placeholder="Project's name" data-validated='false' onkeyup="checkExistingValue(this, name_json)" >
				</div>
				
			</div>
			
			<div class="form-group">
				<div class="col-xs-4">
					<label>Nation:</label>
					<Select class="form-control" type="text" name="location" placeholder="Nation" >
						<option></option>
						<option value="Australia">Australia</option>
						<option value="United State">United State</option>
						<option value="United Kingdom">United Kingdom</option>
						<option value="Canada">Canada</option>
						<option value="Singapore">Singapore</option>
						<option value="Honkong">Honkong</option>
						<option value="France">France</option>
						<option value="Vietnam">Vietnam</option>
					</select>
				</div>
				<div class="col-xs-8">
					<label>Industry:</label>			
					<select  name="industry"  class="form-control single-select">						
								<option></option>
								<?php 			
																	
									include_once('../process/_cschema-connect.php');
									$sql = "SELECT id, name FROM industry";
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
			
			<div  class="form-group">
				<div class="col-xs-6">
					<label>Customer:</label>				
					<select  name="leadId"  class="form-control single-select">						
													
							<option></option>
							<?php 																
								
								$sql = "SELECT id, firstName, lastName FROM lead";
								
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
				<div class="col-xs-6">
					<label>Controller:</label>				
					<select  class="form-control" name="controller"  >						
													
							<option></option>
							<?php 																
								
								$sql = "SELECT id, firstName, lastName FROM user WHERE class = 2";
								
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
			<div class="form-group">
				<div class="col-xs-12">
					<label>Document Link:</label>			
					<input class="form-control" type="text" name="link" placeholder="Document Link" >
				</div>
			</div>
			<div  class="form-group">
				<div class="col-xs-6">
					<label>Confirm date:</label>		
					<input name="confirmDate" class="form-control" type="date">				
				</div>
				<div class="col-xs-6">
					<label>Close date: </label>				
					<input name="closeDate" class="form-control" type="date">				
				</div>					
			</div>
		
			<div  class="form-group">
				<div class="col-xs-12">
					<label>Summary:</label>				
					<textarea name="summary" type="text"></textarea>					
				</div>					
			</div>			
			<div class="form-group">
				<div class="col-xs-12">
					<label>Status:</label>			
				</div>
				<div class="col-xs-12">
					<span class="radio">
						<label class="radio-inline"><input  class="radio-input" type="radio" name="status" value='0' >Open</label>
						<label class="radio-inline"><input  class="radio-input" type="radio" name="status" value='1' >Close</label>
					</span>
				</div>
			</div>
			<!-- Hidden input -->		
			<div class="form-group" style="visibility: hidden" >				
				<div class="form-field">
					<input  name="data" value="project">
				</div>
			</div>
			<div class="form-group">			
				<?php include_once('form_button.php'); ?>
			</div>			
		</form>
	</div>

</div> <!-- End of Form -->
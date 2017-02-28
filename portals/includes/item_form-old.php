<div class="form panel panel-default"  id="sform">
	<div class="panel-heading">
		<span>Record inputs</span><span id="form-notice" class="pull-right"></span>
	</div>
	<div class="panel-body"> 
		<form class="long-form" action='' method="post" >
			<div class="form-group">
				<div class="form-label">
					Record: 
				</div>
				<div class="form-field">
					<input type="text" name="id" placeholder="auto" readonly  >
				</div>
			</div>
			<div class="form-group hidden">
				<div class="form-label">
					Level: 
				</div>
				<div class="form-field">
				
				
					<select id="level-input" name="level" class="form-control not-fill"  >
						<option ></option>
						<option value="1">Section</option>
						<option value="2">Activity</option>
						<option value="3">Material</option>
					</select>
					
				</div>
			</div>
			<div class="form-group">
				<div class="form-label">
					Code: 
				</div>
				<div class="form-field">
					<input type="text" name="code" placeholder="code"    >
				</div>
			</div>
			<div class="form-group">
				<div class="form-label">
					Name:
				</div>
				<div class="form-field">
					<input type="text" name="name" placeholder="name"   >
				</div>
			</div>
			<div  class="form-group">
				<div class="form-label">
					Parent:
				</div>
				<div class="form-field">
					
					<select id="parent-field" name="parent_id" placeholder="parent" class="form-control">						
								<option></option>
								<?php 
									include_once('../process/_cschema-connect.php');
										$sql = "SELECT code, name FROM wbs_global";
										$result = $conn->query($sql);
										if($result->num_rows > 0)
										{									
											while($row = $result->fetch_assoc())
											{												
												echo "<option value=".$row['code'].">".$row['code']." - ".$row['name']."</option>";												
											}					
										}
								?>


								<script>	
								/*							
									 var request;
									 $(document.body).on('change', 'select[name*="level"]', function(){ 
										   var form = $(this).parentsUntil('#sform','form'), serializedData;
										   var target = $('select[name="parent_id"]');
											if($(form).attr('action') != '')
												return;
											event.preventDefault();
											var button; 
											if (request) {
												request.abort();
											}
											var level = $('form select[name="level"]').val();											
											serializedData = 'data=item&level='+level+'&query=fetch_level';
											
											request = $.ajax({
												url: "../process/_data-queries.php",
												type: "post",
												data: serializedData,
												success: function(response, status, xhttp) {													
													var data = JSON.parse(response);
													
													displayOptions(target, data);
												}
											});											
																	
									});	
									*/						
								</script>
				
								
					</select>
						
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
<div class="form panel panel-default"  id="sform">
	<div class="panel-heading">
		<span>Record inputs</span><span id="form-notice" class="pull-right"></span>
	</div>
	<div class="panel-body"> 
		<form class="short-form" action="" method="post" >
			<div class="form-group">
				<div class="col-xs-4">				
					<label for="input1" >Id:</label>
					<input id="input1" class="form-control" type="text" name="id" placeholder="Auto" readonly >							
				</div>
				<div class="col-xs-4">
					<label for="input2" >First Name:</label>
					<input id="input2" class="form-control" type="text" name="firstName" placeholder="First Name" required>				
				</div>
				<div class="col-xs-4">
					<label for="input3">Last Name:</label>
					<input id="input3" class="form-control" type="text" name="lastName" placeholder="Last Name" required>
				
				</div>
			</div>
			<div  class="form-group">
				<div class="col-xs-6">	
					<label for="input4" >Email:</label>		
					<input id="input4" class="form-control" type="text" name="email" placeholder="Email" data-validated='false' onkeyup="checkExistingValue(this, email_json)" required>
				</div>
				
				<div class="col-xs-6">	
					<label for="input5" >Phone:</label>			
					<input id="input5" class="form-control" type="text" name="phone" placeholder="Phone" required>
				</div>
			</div>
            <div class="form-group">
				<div class="col-xs-12">	
					<label for="input6" >Organization:</label>				
					<input id="input6" class="form-control" type="text" name="organization" placeholder="Organization">
				</div>
			</div>
            <div class="form-group">
				<div class="col-xs-6">	
					<label for="input7" >Education:</label>			
					<select id="input7" class="form-control" type="text" name="education" >
                        <option></option>
                        <option value="0">DS</option>
                        <option value="1">BS</option>
                        <option value="2">MS</option>
						<option value="3">Ph.D</option>
						<option value="4">Other</option>
                    </select>					
				</div>			
				<div class="col-xs-6">
					<label for="input8" >College:</label>		
					<input id="input8" class="form-control" type="text" name="college" >			
				</div>
			</div>
            <div class="form-group">
				<div class="col-xs-6">
					<label for="input9" >Class:</label>				
					<select id="input9" class="form-control" type="text" name="class"  >
						<option></option>
                        <option value="2">Employee</option>
                        <option value="1">Power user</option>
                        <option value="0">Super user</option>
					</select>
				</div>		
				<div class="col-xs-6">
					<label for="input10" >Status:</label>			
					<select id="input10" class="form-control" id="input10"  type="text" name="status">
                        <option></option>
                        <option value="1">Activated</option>
                        <option value="0">Deactivated</option>                     
                    </select>
				</div>
			</div>
			<!-- Hidden input -->
			<div class="form-group" style="visibility: hidden" >
				
				<div class="form-field">
					<input  name="data" value="employee">
				</div>
			</div>	
			 <div class="form-group">				
				<?php include_once('form_button.php'); ?>
			</div>						
		</form>
	</div>

</div><!-- End of Form -->
<div class="form panel panel-default"  id="sform">
	<div class="panel-heading" >
		<span>Record inputs</span><span id="form-notice" class="pull-right"></span>
	</div>
	<div class="panel-body"> 
			<form class="long-form" action="" method="post" >
			<div class="form-group">
				<div class="form-label">
					Code:
				</div>
				<div class="form-field">
					<input type="text" name="id" placeholder="code" data-original-title="" title="" data-validated='false' onkeyup="checkExistingValue(this, id_json)" required>
				</div>
			</div>
			<div class="form-group">
				<div class="form-label">
					Name:
				</div>
				<div class="form-field">
					<input type="text" name="name" placeholder="industry" data-original-title="" title="" data-validated='false' onkeyup="checkExistingValue(this, name_json)" required>
				</div>
			</div>
			<div id="loadSec"  class="form-group">							
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
					<input  name="data" value="industry">
				</div>
			</div>
			<div class="form-group">
				<?php include_once('form_button.php'); ?>
			</div>
		</form>
	</div>				
</div>	<!-- End of Form -->		
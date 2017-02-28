
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta name="robots" content="noindex">

<title>cschema | The Construction schema</title>
<link href="/ico/logo.png" rel="icon" >
<link rel="stylesheet" href="../css/bootstrap.min.css">
<link href="../css/bootstrap-theme.css" rel="stylesheet" />
<script src="../js/jquery.min.js"></script>
<script src="../js/bootstrap.min.js"></script>
<link href="../dist/css/select2.css" rel="stylesheet" />
<link href="../css/cschema.css" rel="stylesheet" />
<script src="../dist/js/select2.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jstree/3.2.1/jstree.min.js"></script>
<style>

</style>
</head>
<?php
session_start();	
error_reporting(E_ALL);
ini_set('display_errors', 1);
   
if(isset($_SESSION['valid']))
{
	include_once('../process/_cschema-connect.php');
	include_once('../process/_functions.php');

	$user = fetchUser($conn, $_SESSION['userId']);
	
}
else
	header('Location: /login.php');


?>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta name="robots" content="noindex">


<title>cschema | The Construction schema</title>
<link href="/ico/logo.png" rel="icon" >
<link rel="stylesheet" href="../css/bootstrap.min.css">
<link href="../css/bootstrap-theme.css" rel="stylesheet" />
<script src="../js/jquery.min.js"></script>
<script src="../js/bootstrap.min.js"></script>
<script src="../js/cschema.js"></script>

<style>


.panel-footer {
  width: 100%;
  position: relative;
  bottom: 0px;
  margin:0px;
  padding: 0px;
  border-top: 1px solid #CCCCCC;  
  background-color: #ffffff;
  color: #1c2127
}
.panel-footer .container {
  margin-top: 0px;
  margin-right: 0px;
  margin-left: auto;
  margin-right: auto
}
.panel-footer .container p{
  line-height: 30px;
  margin: 0px;
  padding: 0px
  
}
</style>
</head>
<body>
<header>
  <?php include_once('../includes/header.php'); ?>
</header>
<div class="container" style="width: 100%;  background-color: #F8F8F8; padding-bottom: 50px;">
	
	<div class="" style="width: 450px; margin-left:auto; margin-right:auto; ">
		<div  id="sform">
			
			<div class="text-center" style="width: 100%;" >
				<h3  >User's information</h3>
				<br/>
			</div>
			<div class=""> 
				<form  action="process/_data-queries.php" method="post" >
					<div class="form-group">
						<div class="col-xs-4">				
							<label for="input1" >Id:</label>
							<input id="input1" class="form-control" type="text" name="id" placeholder="Auto" value="<?php echo $user[0]; ?>" readonly >							
						</div>
						<div class="col-xs-8">	
							<label for="input2" >Email:</label>		
							<input id="input2" class="form-control" type="text" name="email" placeholder="Email" value="<?php echo $user[1]; ?>" readonly  required>
						</div>
					
					</div>
					<div  class="form-group">
						<div class="col-xs-12">
							<label for="input3" >First Name:</label>
							<input id="input3" class="form-control" type="text" name="firstName" placeholder="First Name" value="<?php echo $user[2]; ?>" required>				
						</div>
					</div>
					<div class="form-group" >
						<div class="col-xs-12">
							<label for="input4">Last Name:</label>
							<input id="input4" class="form-control" type="text" name="lastName" placeholder="Last Name"  value="<?php echo $user[3]; ?>"required>						
						</div>
					</div>
					<div class="form-group">						
						<div class="col-xs-12">	
							<label for="input5" >Phone:</label>			
							<input id="input5" class="form-control" type="text" name="phone" placeholder="Phone" value="<?php echo $user[4]; ?>" required>
						</div>
					</div>			
					
					</div>
					<div class="form-group">
						<div class="col-xs-12">	
							<label for="input6" >Organization:</label>				
							<input id="input6" class="form-control" type="text" name="organization" placeholder="Organization" value="<?php echo $user[5]; ?>">
						</div>
					</div>
					<div class="form-group">
						<div class="col-xs-12">	
							<label for="input7" >Education:</label>			
							<select id="input7" class="form-control" type="text" placeholder="Education" name="education" value="<?php echo $user[6]; ?>" >
								<option></option>
								<option value="0">DS</option>
								<option value="1">BS</option>
								<option value="2">MS</option>
								<option value="3">Ph.D</option>
								<option value="4">Other</option>
							</select>
							<input id="educationhidden" class="hidden" name="statushidden" value="<?php echo $user[6]; ?>" >
							<script>
								$(document).ready(function(){
									var e = $('input#educationhidden').val();								
									$('select[name="education"]').children("option[value='" + e + "']").prop("selected", true);
								})
								 
							</script>					
						</div>	
					</div>
					<div class="form-group">
						<div class="col-xs-12">
							<label for="input8" >College:</label>		
							<input id="input8" class="form-control" type="text" name="college" value="<?php echo $user[7]; ?>" >			
						</div>
					</div>
									
					<div class="form-group">				
						<div class="col-xs-12">
							<label for="input9" >Status:</label>			
							<select id="input9" class="form-control" type="text" name="status" >
								<option></option>
								<option value="1">Activated</option>
								<option value="0">Deactivated</option>                     
							</select>
							<input id="statushidden" class="hidden" name="statushidden" value="<?php echo $user[9]; ?>" >
							<script>
								$(document).ready(function(){
									var e = $('input#statushidden').val();								
									$('select[name="status"]').children("option[value='" + e + "']").prop("selected", true);
								})
								 
							</script>
						</div>
					</div>
					<!-- Hidden input -->
					<div class="form-group"  style="visibility: hidden" >
						
						<div class="form-field">
							<input  name="data" value="userprofile">
						</div>
					</div>	
					<div class="form-group">
						<div class="col-xs-3">				
							<input id="input10" class="btn btn-info form-control" type="button" name="save" value="Save" >
						</div>
					</div>						
				</form>
			</div>

		</div><!-- End of Form -->
	</div>
</div>
<div class="panel-footer" >
	<div class="container">					
		<p class="text-center">&copy; 2017 QsCompanion.</p>
	</div>
</div>

</body>
</html>
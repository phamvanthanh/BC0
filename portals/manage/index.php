<?php    
    session_start();	
    error_reporting(E_ALL);
    ini_set('display_errors', 1);
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
<link href="../dist/css/select2.css" rel="stylesheet" />
<link href="../css/cschema.css" rel="stylesheet" />
<script src="../dist/js/select2.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jstree/3.2.1/jstree.min.js"></script>
<style>

</style>
</head>
<body>
<div id="body">
	<header>
	<table width="100%" cellpadding="2" cellpadding="10" >
			<tbody >
				<tr  >
					<td class="col-sm-10">               
						<ul class="list-inline">
							<li><a  href="/"><img src="/ico/logo-full-black.png" alt="QsCompanion" height="30px" /></a></li>
												
						</ul>                    
					</td>
					<td class="col-sm-2">
						<span class="pull-right" >
							<?php
								
								if(isset($_SESSION["valid"])) 
								{				
									echo "<div class=\"dropdown\">
									<a href=\"\" class=\"dropdown-toggle\"  data-toggle=\"dropdown\">".$_SESSION["username"]."<span class=\"caret\"></span></a>
								
									<ul class=\"dropdown-menu\">
										<li><a href=\"/portals/users/uprofile.php\">Profile</a></li>
										<li><a href=\"../process/_signout.php\">Sign out</a></li>
										
									</ul>
									</div>";

								
								}
								else
									echo "<a href=\"/login.php\">Sign in</a>";
							
							?>
						</span>
					</td>
					
				</tr>
			
			</tbody>
		</table> 

	</header>
	<div>
			
		<div id="left-pane" class=" col-sm-2">
			<?php include_once('../includes/left_panel.php'); ?>
		</div><!-- end of left panel -->
		<div id="right-pane" class=" col-sm-10"  >				
			<div id="divdash" class="row " >
				
			
			</div>
			
		</div>

	</div>
</div> <!--End of body div -->
<div id="footer" class="panel-footer">
	<div class="container">			
		<p class="text-center">&copy; 2016 QsCompanion.</p>
	</div>
</div>

<script type="text/javascript" src="../js/cschema.js"></script>
<script type="text/javascript" src="../js/psystem.js"></script>

</body>
</html>

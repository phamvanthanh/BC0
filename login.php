<?php
	session_start();
	error_reporting(E_ALL);
	ini_set('display_errors', 1);

	if(isset($_SESSION["valid"]))
	{
		switch($_SESSION["class"])
		{
			case 0:
			case 1:
				header('Location: /portals/manage/index.php');
				break;
			case 2:
				header('Location: /portals/projects/index.php');
				break;
			default:
				break;
		}

	}
?>
<!doctype html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta name="robots" content="noindex">

<title>QsCompanion | The #1 Take Off Service</title>
<link href="/ico/logo.png" rel="icon" >

<script type="text/javascript" src="/js/leadForm.js"></script>

<link href="/css/bootstrap.css" rel="stylesheet" />
<link href="/css/network.css" rel="stylesheet" />
<link href="/css/bootstrap-theme.css" rel="stylesheet" />

</head>
<body>
<header>
<div class="white-bar">
	<nav class="navbar">
		<div class="container">
			<div>
				<div class="col-sm-12 col-xs-12">
					<a href="/"><img class="logo" src="/ico/logo-full-black.png" alt="QsCompanion" height="32px" /></a>
				</div>
			</div>
		</div>
	</nav>
</div> <!-- OK -->

</header>
<div class="border">
</div>
<div class="body">
	<div class="container">
		<div class="form col-sm-3 login">
			<form action="/portals/process/_login.php" method="post">
				<div class="form-group">
  					<input type="text" name="email" placeholder="Email address">
				</div>
				<div class="form-group">
  					<input type="password" name="password" placeholder="Password">
				</div>
				<div class="checkbox">
					
				</div>
				<div class="form-group">
 					 <input class="btn btn-primary"type="submit" name="login" value="Login">
					  <div class="text-center">
					  	<p class="light-note"> FOR QSCOMPANION WORK GROUP ONLY</p>
					  </div>
				</div>
			</form>
		</div>
		<div class="col-sm-7">

		</div>
	</div>
</div><!-- end off body div -->

<div class="panel-footer">
	<div class="container">					
		<p class="text-center">&copy; 2017 QsCompanion.</p>
	</div>
</div>
</body>
</html>

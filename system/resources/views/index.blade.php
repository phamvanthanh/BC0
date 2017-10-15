
<!DOCTYPE html>


<html lang="en">
<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	
	<meta name="csrf-token" content="{{ csrf_token() }}">
	<title>BreakCost</title>
	<link href="/images/logo.png" rel="icon" >
	<script type="text/javascript" src="/js/core/jquery.min.js"></script>
	<script type="text/javascript" src="/js/core/bootstrap.min.js"></script>
	<script src="https://js.pusher.com/4.1/pusher.min.js"></script>
	<link href="/css/icons/icomoon/styles.css" rel="stylesheet" type="text/css">
	<link href="/css/core/bootstrap_mod.css" rel="stylesheet" type="text/css">
	<link href="/css/app.css" rel="stylesheet" type="text/css">

  
<script>

$( window ).on( 'unload', function() {
   $.ajax({
	   type: 'POST',
	   url: 'api/users/status/offline',
	   async:false,
	   data:{
		   "_token": "{{ csrf_token() }}",
	   }
	 }).done(function(data) {                
        console.log('useroffline');
    });
} );

</script>

</head>


<body>
<div id="overlay">
</div>
@if(Auth::check())
<div id="app" >
<form id="logout-form" action="{{ route('logout') }}" method="POST" style="display: none;">
		{{ csrf_field() }}
</form>

<router-view v-if="loggedIn" ></router-view>
			
	
</div>
 <script type="text/javascript" src="/js/app.js"></script>
@else
	<script>window.location = "login";</script>
	
@endif

</body>
</html>

    
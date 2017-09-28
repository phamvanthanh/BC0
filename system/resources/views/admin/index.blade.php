<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>QsCompanion - Administrator</title>

	<!-- Global stylesheets -->
	<!--<link href="/css/extensions/font-family.css" rel="stylesheet" type="text/css">-->
	<link href="/css/extensions/icons/icomoon/styles.css" rel="stylesheet" type="text/css">
	<link href="/css/extensions/bootstrap.css" rel="stylesheet" type="text/css">
	<link href="/css/extensions/core.css" rel="stylesheet" type="text/css">
	<link href="/css/extensions/components.css" rel="stylesheet" type="text/css">
	<link href="/css/extensions/colors.css" rel="stylesheet" type="text/css">
	<meta name="csrf_token" content="{!! csrf_token() !!}"/>
	<script type="text/javascript" src="/js/extensions/core/libraries/jquery.min.js"></script>
	<script type="text/javascript" src="/js/extensions/core/libraries/bootstrap.min.js"></script>
	<script type="text/javascript" src="/js/extensions/core/app.js"></script>
  



	<!-- /global stylesheets -->

<script>

</script>



	<!-- /theme JS files -->

</head>

<body>
<div id="app">
	

	<!-- Main navbar -->
		@section('header')
			@include('core.header')			
		@show
	
	<!-- /main navbar -->


	<!-- Page container -->
	<div class="page-container">

		<!-- Page content -->
		<div class="page-content">

			<!-- Main sidebar -->
				@section('sidebar')
						@include('core.sidebar')
				@show
			<!-- /main sidebar -->

				
			<!-- Main content -->
				@section('content')
					<router-view></router-view>
				
				@show
				
			<!-- /main content -->

		</div>
		<!-- /page content -->
		
	
	</div>
	<!-- /page container -->
	<!-- Core JS files -->


<!-- /core JS files -->

<!-- Theme JS files -->
</div>
 <script type="text/javascript" src="/js/app.js"></script>


</body>
</html>

    

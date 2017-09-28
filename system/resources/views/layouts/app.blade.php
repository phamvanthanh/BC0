<!DOCTYPE html>
<html lang="{{ config('app.locale') }}">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <!-- CSRF Token -->
    <meta name="csrf-token" content="{{ csrf_token() }}">    

    <title>{{ config('app.name', 'BreakCost') }}</title>
    <link href="/images/logo.png" rel="icon" >
    <!-- Styles -->
    <link href="{{ asset('css/core/bootstrap_mod.css') }}" rel="stylesheet">
    <link href="{{ asset('css/authentication.css') }}" rel="stylesheet">
</head>
<body>
    <div class="white-bar">
        <nav class="navbar ">
            <div class="container">
                <div class="navbar-header">

                    <!-- Collapsed Hamburger -->
                    <!--<button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#app-navbar-collapse">
                        <span class="sr-only">Toggle Navigation</span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                    </button>-->

                    <!-- Branding Image -->
                 
                    <a class="navbar-brand" href="https://breakcost.com" style="font-size: 26px; font-weight: 600" href="#"><span style="color:#3097D1 !important" >BREAK</span><span style="color:#ff3860 !important">COST</span></a>
                </div>

                <div class="collapse navbar-collapse" id="app-navbar-collapse">
                    <!-- Left Side Of Navbar -->
                    <ul class="nav navbar-nav">
                        &nbsp;
                    </ul>

                    <!-- Right Side Of Navbar -->
                    <!-- Authentication Links -->
                    <ul class="nav navbar-nav navbar-right">
                        <li><a>+84-463-288-901</a></li>
                        @if (Auth::guest())
                            <li><a href="{{ route('login') }}">Login</a></li>
                            <!--<li><a href="{{ route('register') }}">Register</a></li>-->
                        @else
                            <li class="dropdown">
                                <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">
                                    {{ Auth::user()->name }} <span class="caret"></span>
                                </a>

                                <ul class="dropdown-menu" role="menu">
                                    <li>
                                        <a href="{{ route('logout') }}"
                                            onclick="event.preventDefault();
                                                        document.getElementById('logout-form').submit();">
                                            Logout
                                        </a>

                                        <form id="logout-form" action="{{ route('logout') }}" method="POST" style="display: none;">
                                            {{ csrf_field() }}
                                        </form>
                                    </li>
                                </ul>
                            </li>
                        @endif
                    </ul>
                </div>
            </div>
        </nav>
    </div>
    <div class="border">
    </div>
    <div id="app" class="body">


        @yield('content')
    </div>

    <div class="panel-footer">
        <div class="container">					
            <p class="text-center">&copy; 2017 BreakCost.</p>
        </div>
    </div>
  
</body>
</html>

@extends('layouts.app')

@section('content')
<div class="container">
    <div class="row">
        <div class="form col-sm-3 login">
       
                    <form  role="form" method="POST" action="{{ route('login') }}">
                        <!--{{ csrf_field() }}-->
                        {!! csrf_field() !!}

                        <div class="form-group{{ $errors->has('email') ? ' has-error' : '' }}">
                       

                       
                                <input id="email" type="email" class="form-control" name="email" value="{{ old('email') }}" required autofocus>

                                @if ($errors->has('email'))
                                    <span class="help-block">
                                        <span>{{ $errors->first('email') }}</span>
                                    </span>
                                @endif
                           
                        </div>

                        <div class="form-group{{ $errors->has('password') ? ' has-error' : '' }}">
              

 
                                <input id="password" type="password"  class="form-control" name="password" required>

                                @if ($errors->has('password'))
                                    <span class="help-block">
                                        <span>{{ $errors->first('password') }}</span>
                                    </span>
                                @endif
                        
                        </div>

                        <div class="form-group">
                          
                                <div class="checkbox">
                                    <label>
                                        <input type="checkbox"  name="remember" {{ old('remember') ? 'checked' : '' }} ><span> Remember Me</span>
                                    </label>
                                </div>
                          
                        </div>

                        <div class="form-group">
                         
                                <input type="submit"  class="btn btn-primary form-control" name="login" value="Login">
                             

                                 <div class="text-center">
                                    <p class="light-note"> FOR AUTHORIZED USERS ONLY</p>
                                </div>

                                <a id="forgot-pw-link" href="{{ route('password.request') }}">
                                    Forgot Your Password?
                                </a>
                          
                        </div>
                    </form>
          
        </div>
    </div>
</div>
@endsection

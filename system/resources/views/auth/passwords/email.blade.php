@extends('layouts.app')

@section('content')
<div class="container">
    <div class="row">
        <div class="col-md-12 ">              
            <div class="">
                @if (session('status'))
                    <div class="alert alert-success">
                        {{ session('status') }}
                    </div>
                @endif

                <form class="form-horizontal" role="form" method="POST" action="{{ route('password.email') }}">
                    {{ csrf_field() }}
                    <div class="form-group">
                        <div class="col-md-3">
                            <h3><label for="email" class="control-label">Reset Password</label></h3>
                        </div>
                    </div>
                    <div class="form-group{{ $errors->has('email') ? ' has-error' : '' }}">
                        

                        <div class="col-md-3">
                            <input id="email" type="email" class="form-control" name="email" value="{{ old('email') }}" placeholder="E-Mail Address" required>

                            @if ($errors->has('email'))
                                <span class="help-block">
                                    <span>{{ $errors->first('email') }}</span>
                                </span>
                            @endif
                        </div>
                    </div>

                    <div class="form-group">
                        <div class="col-md-3">
                            <button type="submit" class="btn btn-primary">
                                Request
                            </button>
                        </div>
                    </div>
                </form>
            </div>          
        </div>
    </div>
</div>
@endsection

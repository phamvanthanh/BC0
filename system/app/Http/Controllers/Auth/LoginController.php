<?php

namespace system\Http\Controllers\Auth;

use system\Http\Controllers\Controller;
use Illuminate\Foundation\Auth\AuthenticatesUsers;
use Illuminate\Http\Request;
class LoginController extends Controller
{
    /*
    |--------------------------------------------------------------------------
    | Login Controller
    |--------------------------------------------------------------------------
    |
    | This controller handles authenticating users for the application and
    | redirecting them to your home screen. The controller uses a trait
    | to conveniently provide its functionality to your applications.
    |
    */

    // use AuthenticatesUsers;

    use AuthenticatesUsers {
        username as protected loginName;
    }

  

    /*
    |--------------------------------------------------------------------------
    | Modify built in login
    |--------------------------------------------------------------------------
    |
    | Override credentitals function from AuthentcatesUsers trait
    | 
    | 
    |
    */

    protected function credentials(Request $request)
    {
        $crendentials=$request->only($this->loginName(), 'password');
        $crendentials['active']=1;
        return $crendentials;

    }

    /**
     * Where to redirect users after login.
     *
     * @var string
     */
     
    protected $redirectTo = '/';

    /**
     * Create a new controller instance.
     *
     * @return void
     */
    public function __construct()
    {
       
       $this->middleware('guest')->except('logout');
    }
   
    
}

<?php

namespace system\Http\Controllers;
use system\Events\UserStatus;
// use system\Events\UserOffline;
use Illuminate\Http\Request;
// use system\Models\User;
use Illuminate\Support\Facades\Auth;

class UserStatusController extends Controller
{
    public function online()
    {
        $user = Auth::user();
        $user->status = 'online';
        $user->save();
        
        event(new UserStatus($user->id));
    }

    public function offline()
    {
        $user = Auth::user();
        $user->status = 'offline';
        $user->save();
        
        event(new UserStatus($user->id));
    }
}

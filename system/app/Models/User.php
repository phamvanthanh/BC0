<?php

namespace system\Models;
use Illuminate\Database\Eloquent\Model;
 use Illuminate\Notifications\Notifiable;

use Illuminate\Foundation\Auth\User as Authenticatable;

use Zizaco\Entrust\Traits\EntrustUserTrait;

class User extends Authenticatable
// class User extends Model
{
    use Notifiable;
    use EntrustUserTrait;

    /**
     * The attributes that are mass assignable.
     *
     * @var array
     */
    protected $fillable = [
        'first_name', 
        'last_name', 
        'email', 
        'phone',  
        'password', 
        'organization', 
        'nation_abbr', 
        'message', 
        'status', 
        'created_at', 
        'updated_at',
        'created_by'
       
    ];

    /**
     * The attributes that should be hidden for arrays.
     *
     * @var array
     */
    protected $hidden = [
        'password', 
        'remember_token',
    ];
    public function nation(){
        return $this->belongsTo('system\Models\Nation');
    }
    public function projects(){
        return $this->hasMany('system\Models\Project')
                    ->with('job')
                    ->with('nation')
                    ->with('industry');
    }
    // public function client() {
    //     return $this->hasManyThrough('system\Models\Role', 'system\Models\RoleUser');
    // }
    public function bid() {
        return $this->hasOne('system\Models\Bid');
    }
    public function awards() {
        return $this->hasMany('system\Models\Bid')
                    ->with('job')
                    ->where('status', 'awarded')
                    ->select(['id', 'job_id', 'user_id']);
    }

    public function activeawards() {
        return $this->hasMany('system\Models\Bid')
                    ->whereHas('job', function($query){
                        $query->where('status', 'active');
                    })
                    ->where('status', 'awarded')
                    ->select(['id', 'job_id', 'user_id']);
    }
    public function active() {
       return $this->hasOne('system\Models\RoleUser')
                   ->with('role')
                   ->where('active', 1)
                   ->select(['id', 'user_id', 'role_id']);
                   
    }
    
      

}

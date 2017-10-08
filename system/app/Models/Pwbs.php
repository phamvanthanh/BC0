<?php

namespace system\Models;

use Illuminate\Database\Eloquent\Model;

class Pwbs extends Model
{
    protected $table = 'pwbs'; 
    protected $fillable = [
        'project_id',
        'code', 
        'parent_code', 
        'name', 
        'description',
        'unit',
        'difference',
        'extension',
        'commit'];    
  
}

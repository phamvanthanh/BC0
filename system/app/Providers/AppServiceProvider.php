<?php

namespace system\Providers;

use Illuminate\Support\ServiceProvider;
use Illuminate\Database\Eloquent\Relations\Relation;
use Laracasts\Generators\GeneratorsServiceProvider;

class AppServiceProvider extends ServiceProvider
{
    /**
     * Bootstrap any application services.
     *
     * @return void
     */
    public function boot()
    {
        Relation::morphMap([
            'project' => 'system\Models\Project',
            'section'   => 'system\Models\Section',
            'package' => 'system\Models\Package'
        ]);
    }

    /**
     * Register any application services.
     *
     * @return void
     */
    public function register()
    {
      // if ($this->app->environment() == 'local') 
       {
          
            $this->app->register('Laracasts\Generators\GeneratorsServiceProvider');
        }
    }
}

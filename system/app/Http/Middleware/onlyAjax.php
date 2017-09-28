<?php

namespace system\Http\Middleware;
use Illuminate\Support\Facades\Auth;
use Closure;


class onlyAjax
{
    /**
     * Handle an incoming request.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \Closure  $next
     * @return mixed
     */
    public function handle($request, Closure $next)
    {
      

       if ( ! $request->ajax())
            return response('Forbidden.', 403);

              
        return $next($request);
    }
}

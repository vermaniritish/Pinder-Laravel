<?php

namespace App\Http\Middleware;
use Illuminate\Auth\Middleware\Authenticate as Middleware;
use Closure;
use Illuminate\Support\Facades\Auth;
use App\Models\Admin\AdminAuth as AdminAuthModal;
use App\Models\Admin\Activities;


class AdminAuth extends Middleware
{
    /**
     * Handle an incoming request.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \Closure  $next
     * @return mixed
     */

    public function handle($request, Closure $next, ...$guards)
    {
        $adminId = AdminAuthModal::getLoginId();
        // Activities::log($request, $adminId);

        if($adminId)
        {
            return $next($request);
        }
        else
        {
            return redirect()->route('admin.login');
        }
    }
}

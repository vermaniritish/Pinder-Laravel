<?php

namespace App\Traits;

use App\Models\Admin\AdminAuth;
use Spatie\Activitylog\Contracts\Activity;

trait LogsCauserInfo {
	public function tapActivity(Activity $activity, string $eventName) {
		$activity->properties = $activity->properties->merge(
			[
				'ip' => request()->getClientIp()
			]
		);
		$activity->admin_id = AdminAuth::getLoginId() ? AdminAuth::getLoginId() : null;
	}
}

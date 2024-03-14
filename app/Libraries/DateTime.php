<?php
namespace App\Libraries;
use Carbon\Carbon;


class DateTime
{
	public static function getDatesBetweenTwoDates($startDate, $endDate, $format = null)
	{
		$startDate = new \DateTime($startDate);

		$endDate = new \DateTime($endDate);
		$endDate   = $endDate->modify('+1 day');
		
		$interval   = new \DateInterval('P1D');
	    
	    $dateRange  = new \DatePeriod($startDate, $interval, $endDate);
	    $dates      = [];

	    foreach ($dateRange as $date) {
	    	if($format)
	    	{
	    		$dates[] = $date->format($format);
	    	}
	    	else
	    	{
		        $date = $date->format('Y-m-d');
		        $dates[] = strtotime($date);
		    }
	    }

	    return array_unique($dates);
	}

	/**
	 * Return hours between 2 times
	 * @param $startTime
	 * @param $endTime
	 */
	public static function getHoursBetweenTwoTimes($starTime, $endTime)
	{
		$dailyTiming = round(
            abs(
                self::hoursToSecondsFormat($starTime) - self::hoursToSecondsFormat($endTime)
            ) / 3600,2);
    	return $dailyTiming;
	} 

	/**
	 * Converts hours to minutes timestamp
	 * @param  mixed $hours     total hours in format HH:MM or HH.MMM
	 * @return int
	 */
	public static function hoursToSecondsFormat($hours)
	{
	    if (strpos($hours, '.') !== false) {
	        $hours = str_replace('.', ':', $hours);
	    }
	    $tmp             = explode(':', $hours);
	    $hours           = $tmp[0];
	    $minutesFromHour = isset($tmp[1]) ? $tmp[1] : 0;

	    return $hours * 3600 + $minutesFromHour * 60;
	}

	/**
	 * Format seconds to quantity
	 * @param  mixed  $sec      total seconds
	 * @return [integer]
	 */

	public static function secondsToQuantity($sec)
	{
	    $seconds = $sec / 3600;

	    $qty = round($seconds, 2);

	    return $qty;
	}

	public static function secondsToTime($seconds, $includeSeconds=true)
	{
		$secs = $seconds%60;
		$mins = floor(($seconds%3600)/60);
		$hours = floor(($seconds%86400)/3600);
		$days = floor(($seconds%2592000)/86400);

		$hours   = ($hours < 10) ? '0' . $hours : $hours;
		$mins    = ($mins < 10) ? '0' . $mins : $mins;
		$secs    = ($secs < 10) ? '0' . $secs : $secs;
		return $hours . ':' . $mins . ':' . $secs;
	}

	public static function daysFromSeconds($seconds, $includeSeconds=true)
	{
		$secs = $seconds%60;
		$mins = floor(($seconds%3600)/60);
		$hours = floor(($seconds%86400)/3600);
		$days = floor(($seconds%2592000)/86400);
		return $days;
	}

	public static function calculateTimeDifference($start_time, $end_time)
	{
		// Convert string times to Carbon instances
		$start_time = Carbon::parse($start_time);
		$end_time = Carbon::parse($end_time);

		// Calculate the time difference in minutes
		$time_difference_minutes = $end_time->diffInMinutes($start_time);

		// Calculate the number of intervals of 30 minutes
		$intervals = floor($time_difference_minutes / 30);

		// Calculate the remaining minutes
		$remaining_minutes = $time_difference_minutes % 30;
		$times = [];
		for($i = 0; $i <= $intervals; $i++)
		{
			$times[] = date('h:i A', strtotime($start_time . ' + ' . ($i*30) . ' minutes'));
		}

		return $times;
	}
}
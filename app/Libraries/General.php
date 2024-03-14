<?php
namespace App\Libraries;

use Illuminate\Support\Str;
use Illuminate\Support\Facades\Http;
use App\Models\Admin\Settings;
use App\Models\Admin\EmailTemplates;
use Illuminate\Support\Facades\Mail;
use Illuminate\Support\Facades\Crypt;
use App\Libraries\SendGrid;
use App\Mail\MyMail;
use App\Models\Admin\EmailLogs;
use Hashids\Hashids;


class General
{
	/** 
	* To make random hash string
	*/	
	public static function hash($limit = 32)
	{
		return Str::random($limit);
	}

	/** 
	* To encrypt
	*/
	public static function encrypt($string)
	{
		return Crypt::encryptString($string);
	}

	/** 
	* To decrypt
	*/
	public static function decrypt($string)
	{
		return Crypt::decryptString($string);
	}

	/** 
	* To encode
	*/
	public static function encode($string)
	{
		$hashids = new Hashids(config('app.key'), 6);
		return $hashids->encode($string);
	}

	/** 
	* To decode
	*/
	public static function decode($string)
	{
		$hashids = new Hashids(config('app.key'), 6);
		return current($hashids->decode($string));
	}

	/** 
	* Url to Anchor Tag
	* @param 
	*/
	public static function urlToAnchor($url)
	{
		return '<a href="' . $url . '" target="_blank">'.$url.'</a>';
	}

	/**
	* To validate the captcha
	* @param $token 
	**/
	public static function validateReCaptcha($token)
	{
		$data = [
			'secret' => Settings::get('recaptcha_secret'),
			'response' => $token,
			'remoteip' => $_SERVER['REMOTE_ADDR']
		];

		$response = Http::asForm()
			->post(
				'https://www.google.com/recaptcha/api/siteverify',
				$data
			);
			
		return $response->successful() && $response->json() && isset($response->json()['success']) && $response->json()['success'];
	}

	/**
	* To send template email
	**/
	public static function sendTemplateEmail($to, $template, $shortCodes = [], $attachments = [], $cc = null, $bcc = null)
	{	
		$template = EmailTemplates::getRow([
				'slug LIKE ?', [$template]
			]);

		if($template)
		{
			$shortCodes = array_merge($shortCodes, [
				'{company_name}' => Settings::get('company_name'),
				'{admin_link}' => General::urlToAnchor(url('/admin')),
				'{website_link}' => General::urlToAnchor(url('/'))
			]);
			$subject = $template->subject;
			$message = $template->description;
			$subject = str_replace (
				array_keys($shortCodes), 
				array_values($shortCodes), 
				$subject
			);

			$message = str_replace (
				array_keys($shortCodes), 
				array_values($shortCodes), 
				$message
			);

			return General::sendEmail(
				$to,
				$subject,
				$message,
				$cc,
				$bcc,
				$attachments,
				$template->slug
			);
		}
		else
		{
			throw new \Exception("Tempalte could be found.", 500);
		}
	}

	/**
	* To send email
	**/
	public static function sendEmail($to, $subject, $message, $cc = null, $bcc = null, $attachments = [], $slug = null)
	{
		$from = Settings::get('from_email');
		$emailMethod = Settings::get('email_method');
		$sent = false;

		$log = EmailLogs::create([
			'slug' => $slug,
			'subject' => $subject,
			'description' => $message,
			'from' => $from,
			'to' => is_array($to) ? implode(', ', $to) : $to,
			'cc' => $cc,
			'bcc' => $bcc,
			'open' => 0,
			'sent' => 0
		]);

		if($log)
		{
			if($emailMethod == 'smtp')
			{
				$company = Settings::get('company_name');

				/** OVERWRITE SMTP SETTIGS AS WE HAVE IN DB. CHECK config/mail.php **/
				$password = Settings::get('smtp_password');
				$password = $password ? General::decrypt($password) : "";
				config([
					'mail.mailers.smtp.host' => Settings::get('smtp_host'),
					'mail.mailers.smtp.port' => Settings::get('smtp_port'),
					'mail.mailers.smtp.encryption' => Settings::get('smtp_encryption'),
					'mail.mailers.smtp.username' => Settings::get('smtp_username'),
					'mail.mailers.smtp.password' => $password,
				]);
				/** OVERWRITE SMTP SETTIGS AS WE HAVE IN DB. CHECK config/mail.php **/

				$mail = Mail::mailer('smtp')
					->to($to);

				if($cc)
					$mail->cc($cc);
				if($bcc)
					$mail->bcc($bcc);
				try
				{
					$mail->send( 
						new MyMail($from, $company, $subject, $message, $attachments) 
					);
					$sent = true;
				}
				catch(\Exception $e)
				{
					$sent = false;
				}
			}
			else if($emailMethod == 'sendgrid')
			{
				$message = view(
		    		"mail", 
		    		[
		    			'content' => $message
		    		]
		    	)->render();

				$sent = SendGrid::sendEmail(
					$to,
					$subject,
					$message,
					$cc,
					$bcc,
					$attachments
				);

			}
			else
			{
				throw new \Exception("Email method does not exist.", 500);	
			}

			// Create email log
			if($sent && $log && $log->id)
			{
				$log->sent = 1;
				$log->save();
			}

			return $sent;
		}
		else
		{
			throw new \Exception("Not able to make email log.", 500);
		}
	}
	public static function autoLink($message)
	{
		 //Convert all urls to links
	    $message = preg_replace('#([\s|^])(www)#i', '$1http://$2', $message);
	    $pattern = '#((http|https|ftp|telnet|news|gopher|file|wais):\/\/[^\s]+)#i';
	    $replacement = '<a href="$1" target="_blank">$1</a>';
	    $message = preg_replace($pattern, $replacement, $message);

	    /* Convert all E-mail matches to appropriate HTML links */
	    $pattern = '#([0-9a-z]([-_.]?[0-9a-z])*@[0-9a-z]([-.]?[0-9a-z])*\\.';
	    $pattern .= '[a-wyz][a-z](fo|g|l|m|mes|o|op|pa|ro|seum|t|u|v|z)?)#i';
	    $replacement = '<a href="mailto:\\1">\\1</a>';
	    $message = preg_replace($pattern, $replacement, $message);
	    return $message;
	}
}
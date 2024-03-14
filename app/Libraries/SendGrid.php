<?php
namespace App\Libraries;

use Illuminate\Http\Request;
use App\Models\Admin\Settings;
use App\Libraries\FileSystem;

class SendGrid
{
	public static function sendEmail($to, $subject, $content, $cc = '', $bcc='', $attachments = [])
	{
		$fromCompany = Settings::get('company_name');
		$fromEmail = Settings::get('from_email');
		$apiKey = Settings::get('sendgrid_api_key');

		$email = new \SendGrid\Mail\Mail();
		$email->setFrom($fromEmail, $fromCompany);
		$email->setSubject($subject);
		if(is_array($to))
		{
			foreach($to as $t)
				$email->addTo($t);
		}
		else
		{
			$email->addTo($to);
		}

		if($cc)
		{
			$email->addCc($cc);
		}

		if($bcc)
		{
			$email->addBcc($bcc);
		}
		$email->addContent("text/plain", $content);
		$email->addContent("text/html", $content);

		if($attachments)
        {
            foreach($attachments as $file)
            {
            	if(file_exists(public_path($file)))
            	{
            		$name = FileSystem::getFileNameFromPath(public_path($file));
	            	$base64File = base64_encode( file_get_contents( public_path($file) ) );
	                $email->addAttachment(
	                		$base64File,
	                		mime_content_type(public_path($file)),
	                		$name
	                	);
	            }
            }
        }

		$sendgrid = new \SendGrid($apiKey);
		try {
			$response = $sendgrid->send($email);
			if($response->statusCode() == 200 || $response->statusCode() == 202)
			{
				return true;
			}
			else
			{
				return false;
			}
		} catch (\Exception $e) {
		    'Caught exception: '. $e->getMessage() ."\n";
		    return false;
		}
	}
}
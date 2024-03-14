<?php

namespace App\Mail;

use Illuminate\Bus\Queueable;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Mail\Mailable;
use Illuminate\Queue\SerializesModels;

class MyMail extends Mailable
{
    use Queueable, SerializesModels;

    var $fromEmail = null;
    var $subject = null;
    var $company = null;
    var $message = null;
    var $attachedFiles = null;
    /**
     * Create a new message instance.
     *
     * @return void
     */
    public function __construct($from, $company, $subject, $message, $attachments = [])
    {
        $this->fromEmail = $from;
        $this->subject = $subject;
        $this->company = $company;
        $this->message = $message;
        $this->attachedFiles = $attachments;
    }

    /**
     * Build the message.
     *
     * @return $this
     */
    public function build()
    {

        $view = $this->subject($this->subject)
            ->from($this->fromEmail, $this->company);

        if($this->attachedFiles)
        {
            foreach($this->attachedFiles as $file)
            {
                if( file_exists(public_path($file)) )
                {
                    $view->attach(public_path($file));
                }
            }
        }
        
        return $view->view('mail')->with(['content' => $this->message]);
    }
}

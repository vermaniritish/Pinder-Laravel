<?php

namespace App\Console\Commands;

use Illuminate\Console\Command;
use App\Models\API\Messages;
use App\Models\API\Users;
use App\Models\Admin\Settings;
use App\Libraries\General;

class MessageCron extends Command
{
    /**
     * The name and signature of the console command.
     *
     * @var string
     */
    protected $signature = 'message:cron';

    /**
     * The console command description.
     *
     * @var string
     */
    protected $description = 'To send notificaitons for unead messages';

    /**
     * Create a new command instance.
     *
     * @return void
     */
    public function __construct()
    {
        parent::__construct();
    }

    /**
     * Execute the console command.
     *
     * @return int
     */
    public function handle()
    {
        $date = date('Y-m-d H:i', strtotime('-10 Minutes'));

        $messages = Messages::select(['messages.id', 'messages.product_id', 'messages.from_id', 'messages.to_id', 'products.user_id'])
            ->leftJoin('products', 'products.id', '=', 'messages.product_id')
            ->where('messages.created', '<=', $date)
            ->where('read', 0)
            ->where('notify', 0)
            ->where('deleted_for_everyone', 0)
            ->groupBy(['product_id', 'from_id', 'to_id'])
            ->get();
            
        foreach($messages as $m)
        {
            $isSeller = $m->to_id == $m->user_id ? true : false;

            $toUser = Users::select(['id', 'email', 'first_name', 'last_name'])->where('id', $m->to_id)->first();
            if($toUser)
            {
                $permission = Users::getPermissions($toUser->id);
                if( $permission && ( ($isSeller && $permission['email_buyer_message']) || (!$isSeller && $permission['email_seller_message']) ) )
                {
                    $fromUser = Users::select(['id', 'first_name', 'last_name'])->where('id', $m->from_id)->first();

                    $codes = [
                        '{from_first_name}' => $fromUser->first_name,
                        '{from_last_name}' => $fromUser->last_name,
                        '{to_first_name}' => $toUser->first_name,
                        '{to_last_name}' => $toUser->last_name,
                        '{view_and_response_button}' => '<a href="'.Settings::get('website_url').'/messages" style="font-size: 28px; display: inline-block; text-align: center; padding: 14px 50px; border-radius: 50px; background-color: #E24268; color: #fff; text-decoration: none; font-weight: 600;">View and respond </a>'
                    ];

                    General::sendTemplateEmail($toUser->email, 'message-notification', $codes);
                }
            }

            Messages::where('created', '<=', $date)
                ->where('read', 0)
                ->where('product_id', $m->product_id)
                ->where('to_id', $m->to_id)
                ->where('from_id', $m->from_id)
                ->update([
                    'notify' => 1
                ]);

        }

        return true;
    }
}

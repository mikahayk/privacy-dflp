<?php
require "vendor/autoload.php";
require "config.php";


use Twilio\Twiml;
$response = new Twiml;
$body = trim($_REQUEST['Body']);
$from = $_REQUEST['From'];

/*
 $body = 'Yes'; 
 $from = '+19174977518';
*/

$allowed_reply_options = [
    'yes', 
    'no'
];

$attendees = [
    ['number' => '+1111111111', 'name' => 'Hayk Mikayelyan', 'img' => 'hayk.jpg', 'seat' => 'A1'],  
   
];





$found_key = array_search($from, array_column($attendees, 'number'));

if($found_key !== false) {
    if (in_array(strtolower($body), $allowed_reply_options)) {
    
        Poll::find('all');
        $is_voted = Poll::find('all',array('conditions' => array('number=?',$from)));
        
        if(!$is_voted) {
            $poll = new Poll();
            $poll->number = $from;
            $poll->name = $attendees[$found_key]['name'];
            $poll->img = $attendees[$found_key]['img'];
            $poll->message = $body;
            $poll->seat = $attendees[$found_key]['seat'];
            $poll->save();
            
            $response->message('Thank you for your vote');            
        } else {
            $response->message('Thank you. You have already voted');
        }
        

        
    } else {
        $response->message('Wrong format. Please correct by following instructions on screen.');
    }
    print $response;
} else {
    $response->message('Thank you for your vote');
    /* Attendee is not in the list of pre-defined contacts */
}



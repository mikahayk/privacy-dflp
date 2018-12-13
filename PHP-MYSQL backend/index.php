<?php
require "vendor/autoload.php";
require "config.php";

$data = array();
$all = Poll::find('all');

foreach($all as $item){
    $data[] = [
        'id' => $item->id,
        'number' => $item->number,
        'name' => $item->name,
        'img' => 'http://magic.hosting.nyu.edu/privacy/img/'.$item->img,
        'message' => $item->message,
        'seat' => $item->seat,
    ];
};

header("HTTP/1.1 200 OK");
header('Content-Type: application/json');
if($data) {
    echo json_encode($data);
} else {
    echo '[]';
}
?>
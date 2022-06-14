<?php
require_once('../Database/connection.db.php');
require_once('../Classes/order.class.php');
$db = getDatabaseConnection('sqlite:../Database/database.db');
$orders = urldecode($_REQUEST['ordersfinal']);
$aux = json_decode($orders);

for($i = 0; $i < sizeof($aux); $i++){
    Order::updateOrderStatus($db, "Waiting for deliver", $aux[$i]->id);
}

header('Location: ' . $_SERVER['HTTP_REFERER']);
?>
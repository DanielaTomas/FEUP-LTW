<?php
    declare(strict_types = 1);

    require_once('../Classes/session.class.php');
    require_once('../Classes/order.class.php');
    require_once('../Database/connection.db.php');


    $session = new Session(); 
    $db = getDatabaseConnection('sqlite:../Database/database.db');


	$order = htmlspecialchars($_POST['order']);

    Order::removeOrder($db, intval($order));
?>
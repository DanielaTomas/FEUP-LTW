<?php
    declare(strict_types = 1);

    require_once('../Classes/session.class.php');
    require_once('../Classes/order.class.php');
    require_once('../Database/connection.db.php');


    require_once('../Classes/restaurant.class.php');
    require_once('../Classes/menu.class.php');
    require_once('../Classes/dish.class.php');

    $session = new Session(); 
    $db = getDatabaseConnection('sqlite:../Database/database.db');

	$quantity = htmlspecialchars($_POST['quantity']);
	$restaurant = htmlspecialchars($_POST['restaurant']);
	$dish = htmlspecialchars($_POST['dish']);

    Order::addOrder($db,Order::countOrders($db)+1,"Pending",intval($restaurant),intval($session::getId()),intval($quantity),intval($dish));  

?>
<?php
  declare(strict_types = 1);

  require_once('../Classes/session.class.php');
  $session = new Session();

  require_once('../Database/connection.db.php');
  require_once('../Templates/common.tpl.php');
  require_once('../Templates/order.tpl.php');
  require_once('../Classes/order.class.php');
  require_once('../Classes/dish.class.php');

  $db = getDatabaseConnection('sqlite:../Database/database.db');
  $orders = Order::getOrders($db, intval(Order::countOrders($db)));
  drawHeader($session);
  drawCart($orders);
  drawFooter(); 
?> 
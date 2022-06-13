<?php
  declare(strict_types = 1);

  require_once('../Classes/session.class.php');
  $session = new Session();

  require_once('../Database/connection.db.php');
  require_once('../Templates/common.tpl.php');
  require_once('../Templates/order.tpl.php');
  require_once('../Classes/order.class.php');
  require_once('../Classes/dish.class.php');
  require_once('../Classes/menu.class.php');
  require_once('../Classes/restaurant.class.php');

  $db = getDatabaseConnection('sqlite:../Database/database.db');
  $orders = Order::getOrders($db, intval(Order::countOrders($db)));

  drawHeader($session);
  drawCart($orders);
  drawFooter(); 
  //$_POST['mode'] == 'Cancel'
  /*if(True)
  {
    $row_id = (int)$_POST['row_id'];
    $ordersUser = $_POST['ordersUser'];
    if($ordersUser[$row_id] != NULL) {
      Order::removeOrder($db, $ordersUser[$row_id]);
    }
   }*/
?> 
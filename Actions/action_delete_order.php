<?php
  declare(strict_types = 1); 

  require_once('../Classes/session.class.php');
  $session = new Session();

  require_once('../Database/connection.db.php');
  require_once('../Classes/order.class.php');
  $db = getDatabaseConnection('sqlite:../Database/database.db');
  $id = intval($_GET['orderid']);
  Order::removeOrder($db, $id);
  $teste = Order::getallquantities($db);
  //array_pop($teste);
  for($i = 0; $i < sizeof($teste); $i++){
    echo $teste[$i];
  }

  //header('Location: ' . $_SERVER['HTTP_REFERER']);
?>
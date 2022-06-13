<?php
  declare(strict_types = 1); 

  require_once('../Classes/session.class.php');
  $session = new Session();

  require_once('../Database/connection.db.php');
  require_once('../Classes/order.class.php');
  $db = getDatabaseConnection('sqlite:../Database/database.db');
  Order::removeOrder($db, intval($_GET['orderid']));

  header('Location: ' . $_SERVER['HTTP_REFERER']);
?>
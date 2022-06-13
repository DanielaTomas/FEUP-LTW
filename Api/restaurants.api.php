<?php
  declare(strict_types = 1);

  require_once('../Classes/session.class.php');
  $session = new Session();

  require_once('../Database/connection.db.php');
  require_once('../Classes/restaurant.class.php');
  require_once('../Templates/common.tpl.php');
  require_once('../Templates/restaurant.tpl.php');

  $db = getDatabaseConnection('sqlite:../Database/database.db');
  $restaurants = Restaurant::searchRestaurants($db, $_GET['search'], intval(Restaurant::countRestaurant($db)));

  echo json_encode($restaurants);
?>
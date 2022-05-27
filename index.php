<?php
  declare(strict_types = 1);

  session_start();

  require_once('Database/connection.db.php');
  require_once('Database/restaurant.class.php');
  require_once('Templates/common.tpl.php');
  require_once('Templates/restaurant.tpl.php');

  $db = getDatabaseConnection();
  $restaurants = Restaurant::getRestaurants($db, intval(Restaurant::countRestaurant($db)));

  drawHeader();
  drawRestaurants($restaurants);
  drawFooter(); 

?> 
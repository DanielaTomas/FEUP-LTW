<?php
  declare(strict_types = 1);

  require_once('Database/connection.db.php');
  require_once('Database/restaurant.db.php');

  require_once('Templates/common.tpl.php');
  require_once('Templates/restaurant.tpl.php');

  $db = getDatabaseConnection();

  $restaurants = getRestaurants($db, 10);

  drawHeader();
  drawRestaurants($restaurants);
  drawFooter(); 

?> 
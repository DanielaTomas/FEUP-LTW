<?php
  declare(strict_types = 1);

  require_once('Database/connection.db.php');
  require_once('Database/restaurant.db.php');

  require_once('Templates/common.tpl.php');
  require_once('Templates/restaurant.tpl.php');

  $db = getDatabaseConnection('sqlite:Database/database.db');

  $restaurants = getRestaurants($db, 10);

  drawHeader1();
  drawRestaurants($restaurants);
  drawFooter(); 

?> 
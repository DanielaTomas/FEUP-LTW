<?php
  declare(strict_types = 1);

  require_once('Templates/common.tpl.php');
  require_once('Templates/restaurant.tpl.php');

  $restaurants = array(
    array('id' => 1, 'name' => 'Restaurant Name 1'),
    array('id' => 2, 'name' => 'Restaurant Name 2'),
    array('id' => 3, 'name' => 'Restaurant Name 3')
  );

  drawHeader();
  drawRestaurants($restaurants);
  drawFooter(); 

?> 

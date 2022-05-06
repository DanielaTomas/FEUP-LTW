<?php
  declare(strict_types = 1);

  require_once('../Templates/common.tpl.php');
  require_once('../Templates/restaurant.tpl.php');

  $menus = array(
    array('id' => 1, 'name' => 'Appetizer'),
    array('id' => 2, 'name' => 'Soup'),
    array('id' => 3, 'name' => 'Meat'),
  );

  $dishes = array(
    array('id' => 1, 'name' => 'Dish Name 1', 'menuId' => 1),
    array('id' => 2, 'name' => 'Dish Name 2', 'menuId' => 1),
    array('id' => 3, 'name' => 'Dish Name 3', 'menuId' => 2),
    array('id' => 4, 'name' => 'Dish Name 4', 'menuId' => 2),
    array('id' => 5, 'name' => 'Dish Name 5', 'menuId' => 3),
    array('id' => 6, 'name' => 'Dish Name 6', 'menuId' => 3)
  );

  drawHeader();
  drawRestaurant('Restaurant Name', $menus, $dishes);
  drawFooter();
?>
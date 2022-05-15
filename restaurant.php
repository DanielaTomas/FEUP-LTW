<?php

declare(strict_types=1);

require_once('Database/connection.db.php');
require_once('Database/restaurant.db.php');

require_once('Templates/common.tpl.php');
require_once('Templates/restaurant.tpl.php');

$db = getDatabaseConnection();

$restaurant = getRestaurant($db, intval($_GET['id']));
$menus = getRestaurantMenus($db, intval($_GET['id']));
drawHeader();
$dishes=array();
$aux = 0;
for($i = 1; $i < 7; $i++){
    array_push($dishes, getMenuDishes($db, $i));
}
drawRestaurant($restaurant['name'], $menus, $dishes);
drawFooter();

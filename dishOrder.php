<?php

require_once('Database/connection.db.php');
require_once('Database/restaurant.db.php');
require_once('Database/dishOrder.db.php');

require_once('Templates/common.tpl.php');
require_once('Templates/dishOrder.tpl.php');

$db = getDatabaseConnection();

$dish = getDish($db, intval($_GET['id']));
$menu = getRestaurantMenu($db, $dish['menuId']);
$restaurant = getRestaurant($db, $menu['id']);

drawHeader();
drawDish($restaurant['id'], $restaurant['name'], $dish['id'], $dish['name'], $dish['description'], $dish['price']);
drawFooter();
<?php

declare(strict_types=1);

require_once('Database/connection.db.php');
require_once('Database/restaurant.db.php');

require_once('Templates/common.tpl.php');
require_once('Templates/restaurant.tpl.php');

$db = getDatabaseConnection();

$restaurant = getRestaurant($db, intval($_GET['id']));
$menus = getRestaurantMenus($db, intval($_GET['id']));
$dishes = getMenuDishes($db, intval($_GET['id']));

drawHeader();
drawRestaurant($restaurant['name'], $menus, $dishes);
drawFooter();

<?php

declare(strict_types=1);

session_start();

require_once('Database/connection.db.php');
require_once('Database/restaurant.class.php');
require_once('Database/menu.class.php');
require_once('Database/dish.class.php');
require_once('Templates/common.tpl.php');
require_once('Templates/restaurant.tpl.php');

$db = getDatabaseConnection();
$restaurant  = Restaurant::getRestaurant($db, intval($_GET['id']));
$menus = Menu::getRestaurantMenus($db, $restaurant->id);
drawHeader();
$dishes=array();
for($i = 1; $i < 7; $i++){
    array_push($dishes, Dish::getMenuDishes($db, $i));
}
drawRestaurant($restaurant->name, $menus, $dishes);
drawFooter();

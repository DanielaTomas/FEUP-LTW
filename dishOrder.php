<?php

session_start();

require_once('Database/connection.db.php');
require_once('Database/restaurant.class.php');
require_once('Database/menu.class.php');
require_once('Database/dish.class.php');
require_once('Templates/common.tpl.php');
require_once('Templates/dishOrder.tpl.php');

$db = getDatabaseConnection();
$dish = Dish::getDish($db, intval($_GET['id']));
$menu = Menu::getMenu($db, $dish->menu);
$restaurant = Restaurant::getRestaurant($db, $menu->id);

drawHeader();
drawDish($restaurant->id, $restaurant->name, $dish);
drawFooter();
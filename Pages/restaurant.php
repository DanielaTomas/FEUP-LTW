<?php

declare(strict_types=1);

session_start();

require_once('../Database/connection.db.php');
require_once('../Classes/restaurant.class.php');
require_once('../Classes/menu.class.php');
require_once('../Classes/dish.class.php');
require_once('../Templates/common.tpl.php');
require_once('../Templates/restaurant.tpl.php');

$db = getDatabaseConnection('sqlite:../Database/database.db');
$restaurant = Restaurant::getRestaurant($db, intval($_GET['id']));
$menus = Menu::getRestaurantMenus($db, $restaurant->id);
drawHeader('../Css/style.css', 'index.php', '../Actions/action_login.php', '../Actions/action_logout.php');
$dishes=array();
for($i = 1; $i < Menu::countMenu($db); $i++){
    array_push($dishes, Dish::getMenuDishes($db, $i));
}
drawRestaurant($restaurant->name, $menus, $dishes);
drawFooter();

<?php

declare(strict_types=1);

require_once('../Classes/session.class.php');
$session = new Session();

require_once('../Database/connection.db.php');
require_once('../Classes/restaurant.class.php');
require_once('../Classes/menu.class.php');
require_once('../Classes/dish.class.php');
require_once('../Templates/common.tpl.php');
require_once('../Templates/restaurant.tpl.php');

$db = getDatabaseConnection('sqlite:../Database/database.db');
$restaurant = Restaurant::getRestaurant($db, intval($_GET['id']));
$menus = Menu::getRestaurantMenus($db, $restaurant->id);
$user = $session::getUsername();
drawHeader($session);
$dishes=array();
for($i = 1; $i < Menu::countMenu($db); $i++){
    array_push($dishes, Dish::getMenuDishes($db, $i));
}
drawRestaurant($session,$restaurant, $menus, $dishes);
drawFooter();

?>
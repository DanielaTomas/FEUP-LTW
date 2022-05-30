<?php
declare(strict_types = 1);

session_start();

require_once('../Database/connection.db.php');
require_once('../Classes/restaurant.class.php');
require_once('../Classes/menu.class.php');
require_once('../Classes/dish.class.php');
require_once('../Templates/common.tpl.php');
require_once('../Templates/dish.tpl.php');

$db = getDatabaseConnection('sqlite:../Database/database.db');
$dish = Dish::getDish($db, intval($_GET['id']));
$menu = Menu::getMenu($db, $dish->menu);
$restaurant = Restaurant::getRestaurant($db, $menu->restaurant);

drawHeader('../Css/style.css', 'index.php', '../Actions/action_login.php', '../Actions/action_logout.php');
drawDish($restaurant->id, $restaurant->name, $dish);
drawFooter();
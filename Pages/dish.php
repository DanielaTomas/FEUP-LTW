<?php
declare(strict_types = 1);

require_once('../Classes/session.class.php');
$session = new Session();

require_once('../Database/connection.db.php');
require_once('../Classes/restaurant.class.php');
require_once('../Classes/menu.class.php');
require_once('../Classes/dish.class.php');
require_once('../Classes/order.class.php');
require_once('../Templates/common.tpl.php');
require_once('../Templates/dish.tpl.php');
require_once('../Classes/user.class.php');

$db = getDatabaseConnection('sqlite:../Database/database.db');
$dish = Dish::getDish($db, intval($_GET['id']));
$menu = Menu::getMenu($db, $dish->menu);
$restaurant = Restaurant::getRestaurant($db, $menu->restaurant);

if(!isset($_SESSION['id'])){
     header('Location: info.php');
}
else{
     drawHeader($session);
     drawDish($restaurant->id, $restaurant->name, $dish);
     drawFooter();
}

?>
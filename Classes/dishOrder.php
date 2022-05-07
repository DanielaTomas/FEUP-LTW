<?php

require_once('../Database/connection.db.php');
require_once('../Database/restaurant.db.php');
require_once('../Database/dishOrder.db.php');

require_once('../Templates/common.tpl.php');
require_once('../Templates/dishOrder.tpl.php');

$db = getDatabaseConnection('sqlite:../Database/database.db');

$restaurant = getRestaurant($db, intval($_GET['id']));
$dish = getDish($db, intval($_GET['id']));

drawHeader2();
drawDish($restaurant['id'], $restaurant['name'], $dish['id'], $dish['name'], $dish['description'], $dish['price']);
drawFooter();

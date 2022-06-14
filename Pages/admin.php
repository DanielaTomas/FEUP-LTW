<?php
require_once('../Classes/session.class.php');
$session = new Session();

require_once('../Database/connection.db.php');
require_once('../Templates/common.tpl.php');
require_once('../Templates/order.tpl.php');
require_once('../Classes/order.class.php');
require_once('../Classes/dish.class.php');
require_once('../Classes/menu.class.php');
require_once('../Classes/restaurant.class.php');
require_once('../Templates/admin.tpl.php');

$db = getDatabaseConnection('sqlite:../Database/database.db');
drawHeader($session);
drawAdmin($db);
drawFooter();
?>
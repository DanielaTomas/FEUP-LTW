<?php
declare(strict_types = 1);
require_once('../Classes/session.class.php');
$session = new Session();

require_once('../Database/connection.db.php');
require_once('../Classes/user.class.php');
require_once('../Templates/common.tpl.php');
require_once('../Templates/user.tpl.php');
$db = getDatabaseConnection('sqlite:../Database/database.db');

$path = $_GET['path'];
$user = User::getUser($db, $session::getId());
drawHeader($session);
drawEditProfileForm($user, $path);
drawFooter();
?>
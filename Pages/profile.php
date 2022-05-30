<?php
  declare(strict_types = 1);

  session_start();

  if (!isset($_SESSION['id'])) die(header('Location: index.php'));

  require_once('../Database/connection.db.php');
  require_once('../Classes/user.class.php');
  require_once('../Templates/common.tpl.php');
  require_once('../Templates/user.tpl.php');

  $db = getDatabaseConnection('sqlite:../Database/database.db');

  $user = User::getUser($db, $_SESSION['id']);

  drawHeader('../Css/style.css', 'index.php', '../Actions/action_login.php', '../Actions/action_logout.php');
  drawProfileForm($user, '../Actions/action_edit_profile.php');
  drawFooter();
?>
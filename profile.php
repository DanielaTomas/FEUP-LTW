<?php
  declare(strict_types = 1);

  session_start();

  if (!isset($_SESSION['id'])) die(header('Location: index.php'));

  require_once('Database/connection.db.php');
  require_once('Database/user.class.php');

  require_once('Templates/common.tpl.php');
  require_once('Templates/user.tpl.php');

  $db = getDatabaseConnection();

  $user = User::getUser($db, $_SESSION['id']);

  drawHeader();
  drawProfileForm($user);
  drawFooter();
?>
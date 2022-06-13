<?php
  declare(strict_types = 1);

  require_once('../Classes/session.class.php');
  $session = new Session();

  if (!$session::login()) die(header('Location: index.php'));

  require_once('../Database/connection.db.php');
  require_once('../Classes/user.class.php');
  require_once('../Templates/common.tpl.php');
  require_once('../Templates/user.tpl.php');

  $db = getDatabaseConnection('sqlite:../Database/database.db');

  $user = User::getUser($db, $session::getId());

  drawHeader($session);
  drawProfileForm($user, '../Actions/action_edit_profile.php');
  drawFooter();
?>
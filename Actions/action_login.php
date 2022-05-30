<?php
  declare(strict_types = 1);

  session_start();

  require_once('../Database/connection.db.php');
  require_once('../Classes/user.class.php');

  $db = getDatabaseConnection('sqlite:../Database/database.db');

  $user = User::getUserWithPassword($db, $_POST['username'], $_POST['password']);
  if ($user) {
    $_SESSION['id'] = $user->id;
    $_SESSION['username'] = $user->username;
  }

  header('Location: ' . $_SERVER['HTTP_REFERER']);
?>
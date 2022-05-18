<?php
  declare(strict_types = 1);

  session_start();

  require_once('Database/connection.db.php');
  require_once('Database/user.class.php');

  $db = getDatabaseConnection();

  $user = User::getCustomerWithPassword($db, $_POST['username'], $_POST['password']);

  if ($user) {
    $_SESSION['id'] = $user->id;
    $_SESSION['username'] = $user->username;
  }

  header('Location: ' . $_SERVER['HTTP_REFERER']);
?>
<?php
  declare(strict_types = 1);

  require_once('../Classes/session.class.php');
  $session = new Session();

  require_once('../Database/connection.db.php');
  require_once('../Classes/user.class.php');

  $db = getDatabaseConnection('sqlite:../Database/database.db');

  $user = User::getUserWithPassword($db, $_POST['username'], $_POST['password']);
  if ($user) {
    $session->setId($user->id);
    $session->setUsername($user->username());
    $session->addMessage('success', 'Login successful!');
  }
  else {
    $session->addMessage('error', 'Wrong username or password!');
  }

  header('Location: ' . $_SERVER['HTTP_REFERER']);
?>
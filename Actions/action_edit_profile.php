<?php
  declare(strict_types = 1); 

  require_once('../Classes/session.class.php');
  $session = new Session();

  if (!$session::getId()) die(header('Location: Pages/index.php'));

  require_once('../Database/connection.db.php');
  require_once('../Classes/user.class.php');
  require_once('../Templates/common.tpl.php');

  $db = getDatabaseConnection('sqlite:../Database/database.db');

  $user = User::getUser($db, $session::getId());

  if ($user) {
    $user->firstLastName = htmlspecialchars($_POST['first_last_name']);
    $user->userAddress = htmlspecialchars($_POST['address']);
    $user->phoneNumber = intval(htmlspecialchars($_POST['phonenumber']));
    $user->username = htmlspecialchars($_POST['username']);
    
    $user->save($db);

    $session->setUsername($user->username());
  }

  header('Location: ../Pages/profile.php');
?>
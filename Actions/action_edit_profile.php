<?php
  declare(strict_types = 1);

  session_start();

  if (!isset($_SESSION['id'])) die(header('Location: Pages/index.php'));

  require_once('../Database/connection.db.php');
  require_once('../Classes/user.class.php');
  require_once('../Templates/common.tpl.php');

  $db = getDatabaseConnection('sqlite:../Database/database.db');

  $user = User::getUser($db, $_SESSION['id']);

  if ($user) {
    $user->firstLastName = $_POST['first_last_name'];
    $user->userAddress = $_POST['address'];
    $user->phoneNumber = intval($_POST['phonenumber']);
    $user->username = $_POST['username'];
    
    $user->save($db);

    $_SESSION['username'] = $user->username;
  }

  header('Location: ../Pages/profile.php');
?>
<?php
  declare(strict_types = 1);

  require_once('../Classes/session.class.php');
  $session = new Session();
  $session::logout();

  header('Location: ../index.php');
?>
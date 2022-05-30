<?php
  declare(strict_types = 1);

  session_start();

  require_once('../Database/connection.db.php');
  require_once('../Templates/common.tpl.php');

  $db = getDatabaseConnection('sqlite:../Database/database.db');

  drawHeader('../Css/style.css', 'index.php', '../Actions/action_login.php', '../Actions/action_logout.php');
  drawFooter(); 

?> 
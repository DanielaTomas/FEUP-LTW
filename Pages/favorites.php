<?php
  declare(strict_types = 1);

  require_once('../Classes/session.class.php');
  $session = new Session();

  require_once('../Database/connection.db.php');
  require_once('../Templates/common.tpl.php');
  require_once('../Templates/favorites.tpl.php');
  require_once('../Classes/favorites.class.php');

  $db = getDatabaseConnection('sqlite:../Database/database.db');
  
  drawHeader($session);
  $favorites = Favorites::getFavorites($db, $session::getId());
  drawFavorites($db,$session,$favorites);
  drawFooter(); 
?>
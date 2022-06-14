<?php
  declare(strict_types = 1); 

  require_once('../Classes/session.class.php');
  require_once('../Database/connection.db.php');
  require_once('../Classes/favorites.class.php');
  $db = getDatabaseConnection('sqlite:../Database/database.db');
  $option = intval($_GET['option']);
  $userid = intval($_GET['userid']);
  $restaurantid = intval($_GET['rid']);
  $dishid = intval($_GET['did']);
  switch($option){
    case 1:
        Favorites::addFavoriteR($db, $userid, $restaurantid);
        break;
    case 2:
        Favorites::removeFavoriteR($db, $userid, $restaurantid, $dishid);
        break;
    case 3:
        Favorites::addFavoriteD($db, $userid, $restaurantid, $dishid);
        break;
    case 4:
        Favorites::removeFavoriteD($db, $userid, $restaurantid, $dishid);
        break;
  }

  header('Location: ../Pages/adminoperation.php');
  ?>
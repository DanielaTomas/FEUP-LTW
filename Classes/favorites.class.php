<?php
  declare(strict_types = 1);

  class Favorites {
    public int $favid;
    public int $userid;
    public int $rid;
    public int $did;


    public function __construct(int $favid, int $userid, int $rid, int $did)
    {
      $this->favid = $favid;
      $this->userid = $userid;
      $this->rid = $rid;
      $this->did = $did;
    }

    static function countFavorites(PDO $db){
      $stmt = $db->prepare('SELECT MAX(FavId) FROM Favorites');
      $stmt->execute(array());
      $max = $stmt->fetch();

    return $max['MAX(FavId)'];
    }

    static function addFavoriteR(PDO $db, int $userid, int $id){
        $stmt = $db->prepare('INSERT INTO Favorites (FavId, UserId, RestaurantId) VALUES (?,?,?)');
      $stmt->execute(array(Favorites::countFavorites($db)+1,$userid,$id));
    }

    static function addFavoriteD(PDO $db, int $userid, int $rid, int $id){
        $stmt = $db->prepare('INSERT INTO Favorites (FavId, UserId, RestaurantId, DishId) VALUES (?,?,?,?)');

      $stmt->execute(array(Favorites::countFavorites($db)+1,$userid,$rid,$id));
    }

    static function removeFavoriteR(PDO $db, int $userid, int $id){
        $stmt = $db->prepare('DELETE FROM Favorites WHERE UserId = ? AND RestaurantId = ? AND DishId = 0');

      $stmt->execute(array($userid,$id));
    }

    static function removeFavoriteD(PDO $db, int $userid, int $rid, int $id){
        $stmt = $db->prepare('DELETE FROM Favorites WHERE UserId = ? AND RestaurantId = ? AND DishId = ?');

      $stmt->execute(array($userid,$rid,$id));
    }

    static function getFavoriteR(PDO $db, int $id)  : array {
      $stmt = $db->prepare('SELECT RestaurantId FROM Favorites WHERE UserId = ? AND DishId = 0');

      $stmt->execute(array($id));

      $Favorites = [];
      while($fav = $stmt->fetch()){
        $Favorites[] = intval($fav['RestaurantId']);
      }
  
      return $Favorites;
    }

    static function getFavoriteD(PDO $db, int $id) : array {
      $stmt = $db->prepare('SELECT FavId, UserId, RestaurantId, DishId FROM Favorites WHERE UserId = ? AND DishId <> 0');

      $stmt->execute(array($id));

      $Favorites = [];
      while($fav = $stmt->fetch()){
        array_push($Favorites, intval($fav['DishId']));
      }
  
      return $Favorites;
    }

    static function verifyFavoriteR(PDO $db, int $id){
      $stmt = $db->prepare('SELECT MAX(RestaurantId) FROM Favorites WHERE UserId = ? AND DishId = 0');
      $stmt->execute(array($id));
      $max = $stmt->fetch();

      if($max['MAX(RestaurantId)'] == 0){
        return False;
      }
      return True;
    }

    static function verifyFavoriteD(PDO $db, int $id){
      $stmt = $db->prepare('SELECT MAX(DishId) FROM Favorites WHERE UserId = ? AND DishId <> 0');
      $stmt->execute(array($id));
      $max = $stmt->fetch();

      if($max['MAX(DishId)'] == 0){
        return False;
      }
      return True; 
    }

    static function getFavorites(PDO $db, int $id) : array {
        $stmt = $db->prepare('SELECT * FROM Favorites WHERE UserId = ?');

      $stmt->execute(array($id));
      $Favorites = [];
      while($fav = $stmt->fetch()){
        $Favorites[] = new Favorites(
          intval($fav['FavId']),
          intval($fav['UserId']),
          intval($fav['RestaurantId']),
          intval($fav['DishId'])
        );
      }
  
      return $Favorites;
  }

}
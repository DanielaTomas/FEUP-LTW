<?php
  declare(strict_types = 1);

  class Restaurant {
    public int $id;
    public string $name;
    public string $image;


    public function __construct(int $id, string $name, string $image)
    { 
      $this->id = $id;
      $this->name = $name;
      $this->image = $image;
    }

    static function countRestaurant(PDO $db){
      $stmt = $db->prepare('
      SELECT MAX(RestaurantId)
      FROM Restaurant
      ');
      $stmt->execute(array());
      $max = $stmt->fetch();

    return $max['MAX(RestaurantId)'];
    }

    static function getRestaurants(PDO $db, int $count) : array {
        $stmt = $db->prepare('SELECT RestaurantId, RestaurantName, RestaurantPhoto FROM Restaurant LIMIT ?');
        $stmt->execute(array($count));
  
      $Restaurants = array();
      while ($Restaurant = $stmt->fetch()) {
        $Restaurants[] = new Restaurant(
          intval($Restaurant['RestaurantId']),
          $Restaurant['RestaurantName'],
          $Restaurant['RestaurantPhoto']
        );
      }
  
      return $Restaurants;
    }

    static function getRestaurant(PDO $db, int $id) : Restaurant {
        $stmt = $db->prepare('
        SELECT RestaurantId, RestaurantName, RestaurantPhoto
        FROM Restaurant
        WHERE RestaurantId = ?
        ');
        $stmt->execute(array($id));
  
      $Restaurant = $stmt->fetch();
  
      return new Restaurant(
        intval($Restaurant['RestaurantId']), 
        $Restaurant['RestaurantName'],
        $Restaurant['RestaurantPhoto']
      );
    }  
  }
?>
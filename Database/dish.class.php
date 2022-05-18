<?php
  declare(strict_types = 1);

  class Dish {
    public int $id;
    public string $name;
    public string $description;
    public float $price;
    public int $menu;

    public function __construct(int $id, string $name, string $description, float $price, int $menu) {
      $this->id = $id;
      $this->name = $name;
      $this->description = $description;
      $this->price = $price;
      $this->menu = $menu;
    }

    static function getMenuDishes(PDO $db, int $id) : array {
        $stmt = $db->prepare('
        SELECT DishId, DishName, DishDescription, Price, MenuId
        FROM Dish
        WHERE MenuId = ?
      ');
      $stmt->execute(array($id));
  
  
      $Dishes = [];

      while ($Dish = $stmt->fetch()) {
        $Dishes[] = new Dish(
          intval($Dish['DishId']), 
          $Dish['DishName'],
          $Dish['DishDescription'],
          floatval($Dish['Price']),
          intval($Dish['MenuId'])
        );
      }

      return $Dishes;
    }

    static function getDish(PDO $db, int $id) : Dish {
      $stmt = $db->prepare('SELECT MenuId, DishId, DishName, DishDescription, Price FROM Dish WHERE DishId = ?');
    $stmt->execute(array($id));

    $Dish = $stmt->fetch();

    return new Dish(
      intval($Dish['DishId']), 
      $Dish['DishName'],
      $Dish['DishDescription'],
      floatval($Dish['Price']),
      intval($Dish['MenuId'])
    );
  }
  }
?>
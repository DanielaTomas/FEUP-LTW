<?php
  declare(strict_types = 1);

  class Menu {
    public int $id;
    public string $name;
    public int $restaurant;

    public function __construct(int $id, string $name, int $restaurant)
    {
      $this->id = $id;
      $this->name = $name;
      $this->restaurant = $restaurant;
    }

    static function getRestaurantMenus(PDO $db, int $id) : array {
        $stmt = $db->prepare('
        SELECT MenuId, MenuType
        FROM Menu natural join RestaurantMenu
        WHERE RestaurantId = ?
        GROUP BY MenuId
      ');
      $stmt->execute(array($id));
  
      $Menus = array();
  
      while ($Menu = $stmt->fetch()) {
        $Menus[] = new Menu(
          intval($Menu['MenuId']), 
          $Menu['MenuType'],
          $id
        );
      }
  
      return $Menus;
    }

    static function getMenu(PDO $db, int $id) : Menu {
        $stmt = $db->prepare('
        SELECT MenuId, MenuType, RestaurantId
        FROM Menu natural join RestaurantMenu
        WHERE MenuId = ?
        GROUP BY MenuId
      ');
      $stmt->execute(array($id));
  
      $Menu = $stmt->fetch();
  
      return new Menu(
        intval($Menu['MenuId']), 
        $Menu['MenuType'],
        intval($Menu['RestaurantId'])
      );
    }

    static function countMenu(PDO $db){
      $stmt = $db->prepare('
      SELECT MAX(MenuId)
      FROM Menu
      ');
      $stmt->execute(array());
      $count = $stmt->fetch();

    return $count['MAX(MenuId)'];
    }
  }
?>
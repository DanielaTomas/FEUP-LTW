<?php
  declare(strict_types = 1);

  class Order {
    public int $id;
    public string $status;
    public int $restaurant;
    public int $userid;
    public int $quantity;

    public function __construct(int $id, string $status, int $restaurant, int $userid, int $quantity) {
      $this->id = $id;
      $this->status = $status;
      $this->restaurant = $restaurant;
      $this->userid = $userid;
      $this->quantity = $quantity;
    }

    static function countOrders(PDO $db){
      $stmt = $db->prepare('
      SELECT MAX(OrderId)
      FROM Orders
      ');
      $stmt->execute(array());
      $max = $stmt->fetch();

    return $max['MAX(OrderId)'];
    }

    static function addDishOrder(PDO $db, int $dishid, int $orderid) {
      $stmt = $db->prepare('INSERT INTO DishOrder(DishId, OrderId) VALUES (?, ?)');
  
      $stmt->execute(array($dishid, $orderid));
  
    }

    static function addOrder(PDO $db, int $id, string $status, int $restaurantid, int $userid, int $quantity, int $dishid){
      $stmt = $db->prepare('INSERT INTO Orders(OrderId, OrderStatus, RestaurantId, UserId, Quantity) VALUES (?, ?, ?, ?, ?)');

      $stmt->execute(array($id, $status, $restaurantid, $userid, $quantity));

      Order::addDishOrder($db, $dishid, $id);
    }

    static function removeOrder(PDO $db, int $id){
      $stmt = $db->prepare('DELETE FROM Orders WHERE OrderId = ?');
      $stmt->execute(array($id));
      $stmt = $db->prepare('DELETE FROM DishOrder WHERE OrderId = ?');
      $stmt->execute(array($id));
    }

    static function getOrders(PDO $db, int $count) : array {
        $stmt = $db->prepare('SELECT OrderId, OrderStatus, RestaurantId, UserId, Quantity FROM Orders LIMIT ?');
      $stmt->execute(array($count));
  
      $orders = [];

      while ($order = $stmt->fetch()) {
        $orders[] = new Order(
          intval($order['OrderId']), 
          $order['OrderStatus'],
          intval($order['RestaurantId']),
          intval($order['UserId']),
          intval($order['Quantity'])
        );
      }

      return $orders;
    }

    static function updateOrderStatus(PDO $db, $status, $id){
      $stmt = $db->prepare('UPDATE Orders SET OrderStatus = ? WHERE OrderId = ?');
      $stmt->execute(array($status,$id));
    }

    static function getDishOrder(PDO $db, int $id){
      $stmt = $db->prepare('
      SELECT DishId, DishName, DishDescription, Price, MenuId, DishPhoto
      FROM Dish natural join DishOrder natural join Orders
      WHERE OrderId = ?
    ');
    $stmt->execute(array($id));

    $Dish = $stmt->fetch();
  
    return $Dish = new Dish(
      intval($Dish['DishId']), 
      $Dish['DishName'],
      $Dish['DishDescription'],
      floatval($Dish['Price']),
      intval($Dish['MenuId']),
      $Dish['DishPhoto']
    );
  }
}
?>
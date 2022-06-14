<?php
  declare(strict_types = 1);

  class Admin {
    public int $id;
    public string $firstLastName;
    public string $username;
    public string $password;
    public string $userAddress;
    public int $phoneNumber;
    public int $restaurant;


    public function __construct(int $id)
    {
      $this->id = $id;
    }

    static function addAdmin(PDO $db, int $id){
        $stmt = $db->prepare('
        INSERT INTO Administrator (UserId) VALUES (?)
      ');

      $stmt->execute(array($id));
    }

    static function addUser(PDO $db, int $id, string $name, string $username, string $password, string $address, int $phonenumber, int $restaurantid){
      $stmt = $db->prepare('INSERT INTO Users(UserId,FirstLastName,Username,Password,UserAddress,PhoneNumber,RestaurantId) VALUES (?, ?, ?, ?, ?, ?, ?) ');
      $stmt->execute(array($id,$name,$username,hash($password,''),$address,$phonenumber,$restaurantid));
    }

    static function addRestaurant(PDO $db, int $id, string $name, string $address, string $category, string $image, int $userid){
        $stmt = $db->prepare('INSERT INTO Restaurant(RestaurantId, RestaurantName, RestaurantAddress, Category, RestaurantPhoto, UserId) VALUES (?, ?, ?, ?, ?, ?)');
        $stmt->execute(array($id,$name,$address,$category,$image, $userid));
    }

    static function addMenu(PDO $db, int $id, string $type, int $restaurant){
        $stmt = $db->prepare('INSERT INTO Menu(MenuId, MenuType) VALUES (?, ?)');
        $stmt->execute(array($id,$type));
        $stmt = $db->prepare('INSERT INTO RestaurantMenu(RestaurantId, MenuId) VALUES (?, ?)');
        $stmt->execute(array($restaurant,$id));
    }

    static function addDish(PDO $db, int $id, string $name, float $price, string $description, int $menuId, string $image) {
      $stmt = $db->prepare('INSERT INTO Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) VALUES (?, ?, ?, ?, ?, ?)');
      $stmt->execute(array($id,$name,$price,$description,$menuId,$image));
    }

    static function updateUser(PDO $db, int $id, string $name, string $username, string $password, string $address, int $phonenumber, int $restaurantid){
      $stmt = $db->prepare('UPDATE Users SET FirstLastName = ?, Username = ?, Password = ?, UserAddress = ?, PhoneNumber = ?, RestaurantId = ? WHERE UserId = ?');
      $stmt->execute(array($name,$username,hash($password,''),$address,$phonenumber,$restaurantid,$id));
    }

    static function updateRestaurant(PDO $db, int $id, string $name, string $address, string $category, string $image, int $userid){
        $stmt = $db->prepare('UPDATE Restaurant SET RestaurantName = ?, RestaurantAddress = ?, Category = ?, RestaurantPhoto = ?, Userid = ? WHERE RestaurantId = ?');
        $stmt->execute(array($name,$address,$category,$image,$userid,$id));
    }

    static function updateMenu(PDO $db, int $id, string $type){
        $stmt = $db->prepare('UPDATE Menu SET MenuType = ? WHERE MenuId = ?');
        $stmt->execute(array($type,$id));
    }

    static function updateDish(PDO $db, int $id, string $name, float $price, string $description, int $menuId, string $image) {
      $stmt = $db->prepare('UPDATE Dish SET DishName = ?, Price = ?, DishDescription = ?, MenuId = ?, DishPhoto = ? WHERE DishId = ?');
      $stmt->execute(array($name,$price,$description,$menuId,$image,$id));
    }

    static function removeAdmin(PDO $db, int $id){
      $stmt = $db->prepare('DELETE FROM Administrator WHERE UserId = ?');
  
    $stmt->execute(array($id));
    }

    static function removeUser(PDO $db, int $id){
      $stmt = $db->prepare('DELETE FROM Users NATURAL JOIN Administrator WHERE UserId = ? ');
      $stmt->execute(array($id));
    }

    static function removeRestaurant(PDO $db, int $id){
        $stmt = $db->prepare('DELETE FROM Restaurant WHERE RestaurantId = ?');
        $stmt->execute(array($id));
        $stmt = $db->prepare('DELETE FROM RestaurantMenu WHERE RestaurantId = ?');
        $stmt->execute(array($id));
    }

    static function removeMenu(PDO $db, int $id){
        $stmt = $db->prepare('DELETE FROM Menu WHERE MenuId = ?');
        $stmt->execute(array($id));
    }

    static function removeDish(PDO $db, int $id) {
      $stmt = $db->prepare('DELETE FROM Dish WHERE DishId = ?');
      $stmt->execute(array($id));
      $stmt = $db->prepare('DELETE FROM DishOrder WHERE DishId = ?');
      $stmt->execute(array($id));
    }

    //function addPromotion(){}



}
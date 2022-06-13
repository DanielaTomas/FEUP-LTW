<?php
  declare(strict_types = 1);

  class User {
    public int $id;
    public string $firstLastName;
    public string $username;
    public string $password;
    public string $userAddress;
    public int $phoneNumber;
    public int $restaurant;


    public function __construct(int $id, string $firstLastName, string $username, string $userAddress, int $phoneNumber, int $restaurant)
    {
      $this->id = $id;
      $this->firstLastName = $firstLastName;
      $this->username = $username;
      $this->userAddress = $userAddress;
      $this->phoneNumber = $phoneNumber;
      $this->restaurant = $restaurant;
    }

    function username() {
      return $this->username;
    }
    
    static function getUserWithPassword(PDO $db, string $username, string $password) : ?User {
      $stmt = $db->prepare('
        SELECT UserId, FirstLastName, Username, UserAddress, PhoneNumber, RestaurantId
        FROM Users 
        WHERE lower(username) = ? AND password = ?
      ');

      $stmt->execute(array(strtolower($username), sha1($password)));
  
      if ($user = $stmt->fetch()) {
        return new User(
            intval($user['UserId']),
            $user['FirstLastName'],
            $user['Username'],
            $user['UserAddress'],
            intval($user['PhoneNumber']),
            intval($user['RestaurantId'])
        );
      }
      return null;
    }

    static function getUser(PDO $db, int $id) : User {
      $stmt = $db->prepare('
        SELECT UserId, FirstLastName, Username, UserAddress, PhoneNumber, RestaurantId
        FROM Users 
        WHERE UserId = ?
      ');

      $stmt->execute(array($id));
      $user = $stmt->fetch();
      
      return new User(
        intval($user['UserId']),
        $user['FirstLastName'],
        $user['Username'],
        $user['UserAddress'],
        intval($user['PhoneNumber']),
        intval($user['RestaurantId'])
    );
    }

    function save(PDO $db) {
      $stmt = $db->prepare('
        UPDATE Users SET FirstLastName = ?, Username = ?, UserAddress = ?, PhoneNumber = ?
        WHERE UserId = ?
      ');

      $stmt->execute(array($this->firstLastName, $this->username, $this->userAddress, $this->phoneNumber, $this->id));
    }

    static function registerUser($db, $userid, $firstLastName, $username, $password, $userAddress, $phoneNumber, $restaurantId){
      $stmt = $db->prepare('
        INSERT INTO Users(UserId, FirstLastName, Username, Password, UserAddress, PhoneNumber, RestaurantId) VALUES (?, ?, ?, ?, ?, ?, ?)
      ');

      $stmt->execute(array($userid, $firstLastName, $username, $password, $userAddress, $phoneNumber, $restaurantId));
    }

    static function maxid(PDO $db){
      $stmt = $db->prepare('
      SELECT MAX(UserId)
      FROM Users
      ');
      $stmt->execute(array());
      $max = $stmt->fetch();

    return $max['MAX(UserId)']+1;
    }

    static function verifyAdmin(PDO $db, int $id){
      $stmt = $db->prepare('
      SELECT UserId
      FROM Administrator
      WHERE UserId = ?
      ');
      $stmt->execute(array($id));
      $admin = $stmt->fetch();

      if($admin != NULL){
        return True;
      }
      return False;
    }

    static function verifyOrders(PDO $db, int $id){
      $stmt = $db->prepare('
      SELECT OrderId
      FROM Orders
      WHERE UserId = ?
      ');
      $stmt->execute(array($id));
      $orders = $stmt->fetch();

      if($orders != NULL){
        return True;
      }
      return False;
    }
  }
?>
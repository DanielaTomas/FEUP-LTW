<?php
  declare(strict_types = 1);

  class Review {
    public int $id;
    public int $score;
    public string $reviewText;
    public int $restaurantId;
    public int $userId;

    public function __construct(int $id, int $score, string $reviewText, int $restaurantId, int $userId)
    { 
      $this->id = $id;
      $this->score = $score;
      $this->reviewText = $reviewText;
      $this->restaurantId = $restaurantId;
      $this->userId = $userId;
    }

    static function countReview(PDO $db){
        $stmt = $db->prepare('
        SELECT MAX(ReviewId)
        FROM Review
        ');
        $stmt->execute(array());
        $max = $stmt->fetch();
  
      return $max['MAX(ReviewId)'];
      }

    static function getReviews(PDO $db, int $count) : array {
        $stmt = $db->prepare('SELECT ReviewId, Score, ReviewText, RestaurantId, UserId FROM Review LIMIT ?');
        $stmt->execute(array($count));
  
      $Reviews = array();
      while ($Review = $stmt->fetch()) {
        $Reviews[] = new Review(
          intval($Review['ReviewId']),
          $Review['Score'],
          $Review['ReviewText'],
          intval($Review['RestaurantId']),
          intval($Review['UserId'])
        );
      }
  
      return $Reviews;
    }

    static function getReview(PDO $db, int $id) : Review {
        $stmt = $db->prepare('SELECT ReviewId, Score, ReviewText, RestaurantId, UserId FROM Review WHERE ReviewId = ?');
        $stmt->execute(array($id));
  
      $Review = $stmt->fetch();
  
      return new Review(
        intval($Review['ReviewId']),
        $Review['Score'],
        $Review['ReviewText'],
        intval($Review['RestaurantId']),
        intval($Review['UserId']),
      );
    }  

    static function updateReview(PDO $db, int $score, string $reviewText, int $restaurantId, int $userId, int $id) {
            $stmt = $db->prepare('UPDATE Review SET Score = ?, ReviewText = ?, RestaurantId = ?, UserId = ? WHERE ReviewId = ?');
            $stmt->execute(array($score,$reviewText,$restaurantId,$userId,$id));
    }  

    static function addReview(PDO $db, int $id, int $score, string $reviewText, int $restaurantId, int $userId) {
        $stmt = $db->prepare('INSERT INTO Review(ReviewId,Score,ReviewText,RestaurantId,UserId) VALUES (?, ?, ?, ?, ?)');
  
        $stmt->execute(array($id, $score,$reviewText,$restaurantId,$userId));
    }

    static function getRestaurantReviews(PDO $db, int $id) : array {
            $stmt = $db->prepare('SELECT ReviewId, Score, ReviewText, UserId FROM Review WHERE RestaurantId = ?');
            $stmt->execute(array($id));
        
            $Reviews = [];
      
            while ($Review = $stmt->fetch()) {
              $Reviews[] = new Review(
                intval($Review['ReviewId']), 
                intval($Review['Score']),
                $Review['ReviewText'],
                $id,
                intval($Review['UserId'])
              );
            }
      
            return $Reviews;
    }

 /*   static function getUserReview(PDO $db, int $id) : User {
      $stmt = $db->prepare('
      SELECT UserId, FirstLastName, Username, UserAddress, PhoneNumber, RestaurantId
      FROM Review
      WHERE UserId = ?
    ');
      $stmt->execute(array($id));

    $User = $stmt->fetch();

    return new User(
      intval($User['UserId']),
      $User['FirstLastName'],
      $User['Username'],
      $User['UserAddress'],
      intval($User['PhoneNumber']),
      intval($User['RestaurantId'])
    );
} */

  }
?>
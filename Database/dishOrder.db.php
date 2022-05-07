<?php

declare(strict_types=1);

function getDish(PDO $db, int $id)
{
  $stmt = $db->prepare('SELECT DishId, DishName, DishDescription, Price FROM Dish WHERE DishId = ?');
  $stmt->execute(array($id));

  $dish = $stmt->fetch();

  return array(
    'id' => $dish['DishId'],
    'name' => $dish['DishName'],
    'description' => $dish['DishDescription'],
    'price' => $dish['Price'],
  );
}

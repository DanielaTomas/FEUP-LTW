<?php

declare(strict_types=1);

function getDish(PDO $db, int $id)
{
  $stmt = $db->prepare('SELECT MenuId, DishId, DishName, DishDescription, Price FROM Dish WHERE DishId = ?');
  $stmt->execute(array($id));

  $dish = $stmt->fetch();

  return array(
    'id' => $dish['DishId'],
    'name' => $dish['DishName'],
    'description' => $dish['DishDescription'],
    'price' => $dish['Price'],
    'menuId' => $dish['MenuId']
  );
}

function getRestaurantMenu(PDO $db, int $id)
{
  $stmt = $db->prepare('SELECT MenuId, MenuType FROM Menu WHERE MenuId = ?');
  $stmt->execute(array($id));

  $menu = $stmt->fetch();

  return array(
    'id' => $menu['MenuId'],
    'type' => $menu['MenuType']
  );

	return $menu;
}
<?php

declare(strict_types=1);

function getRestaurants(PDO $db, int $count)
{
	$stmt = $db->prepare('SELECT RestaurantId, RestaurantName FROM Restaurant LIMIT ?');
	$stmt->execute(array($count));

	$restaurants = array();
	while ($restaurant = $stmt->fetch()) {
		$restaurants[] = array(
			'id' => $restaurant['RestaurantId'],
			'name' => $restaurant['RestaurantName']
		);
	}

	return $restaurants;
}

function getRestaurant(PDO $db, int $id): array
{
	$stmt = $db->prepare('
    SELECT RestaurantId, RestaurantName
    FROM Restaurant
    WHERE RestaurantId = ?
    ');
	$stmt->execute(array($id));

	$restaurant = $stmt->fetch();


	return array(
		'id' => $restaurant['RestaurantId'],
		'name' => $restaurant['RestaurantName']
	);
}

function getRestaurantMenus(PDO $db, int $id): array
{
	$stmt = $db->prepare('
      SELECT MenuId, MenuType
      FROM Menu natural join RestaurantMenu
      WHERE RestaurantId = ?
      GROUP BY MenuId
    ');
	$stmt->execute(array($id));

	$menus = array();

	while ($menu = $stmt->fetch()) {
		$menus[] = array(
			'id' => $menu['MenuId'],
			'name' => $menu['MenuType']
		);
	}

	return $menus;
}

function getMenuDishes(PDO $db, int $id): array
{
	$stmt = $db->prepare('
      SELECT DishId, DishName, DishDescription, Price, MenuId
      FROM Dish
      WHERE MenuId = ?
    ');
	$stmt->execute(array($id));

	$dishes = array();

	while ($dish = $stmt->fetch()) {
		$dishes[] = array(
			'id' => $dish['DishId'],
			'name' => $dish['DishName'],
			'description' => $dish['DishDescription'],
			'price' => $dish['Price'],
			'menuId' => $dish['MenuId']
		);
	}

	return $dishes;
}

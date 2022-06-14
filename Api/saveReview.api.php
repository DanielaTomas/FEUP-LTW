<?php
    declare(strict_types = 1);

    require_once('../Classes/session.class.php');
    require_once('../Classes/review.class.php');
    require_once('../Database/connection.db.php');
    require_once('../Templates/restaurant.tpl.php');


    $session = new Session(); 
    $db = getDatabaseConnection('sqlite:../Database/database.db');


	//$restaurant = Restaurant::getRestaurant($db,intval($_GET(['id'])));
	$score = htmlspecialchars($_POST['score']);
    $comment = htmlspecialchars($_POST['comment']);

    Review::addReview($db, Review::countReview($db)+1, intval($score), $comment,1,intval($session::getId()));

	/*$sql = "INSERT INTO `crud`( `name`, `email`, `phone`, `city`) 
	VALUES ('$score')";
	if (mysqli_query($conn, $sql)) {
		echo json_encode(array("statusCode"=>200));
	} 
	else {
		echo json_encode(array("statusCode"=>201));
	}
	mysqli_close($conn);*/
?>
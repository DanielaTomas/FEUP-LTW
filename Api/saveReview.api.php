<?php
    declare(strict_types = 1);

    require_once('../Classes/session.class.php');
    require_once('../Classes/review.class.php');
    require_once('../Database/connection.db.php');
    require_once('../Templates/restaurant.tpl.php');


    $session = new Session(); 
    $db = getDatabaseConnection('sqlite:../Database/database.db');


	$score = htmlspecialchars($_POST['score']);
    $comment = htmlspecialchars($_POST['comment']);
    $restaurantid = htmlspecialchars($_POST['restaurantid']);


    Review::addReview($db, Review::countReview($db)+1, intval($score), $comment,intval($restaurantid),intval($session::getId()));
?>
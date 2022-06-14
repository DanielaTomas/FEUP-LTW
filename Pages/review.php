<?php
    declare(strict_types = 1);

    require_once('../Classes/session.class.php');
    require_once('../Classes/restaurant.class.php');
    require_once('../Classes/review.class.php');
    require_once('../Database/connection.db.php');
    require_once('../Templates/common.tpl.php');
    require_once('../Templates/review.tpl.php');

    $session = new Session(); 
    $db = getDatabaseConnection('sqlite:../Database/database.db');

    $restaurant = Restaurant::getRestaurant($db, intval($_GET['id']));
    $reviews = Review::getRestaurantReviews($db,$restaurant->id);

    drawHeader($session);
    drawReview($restaurant);
    drawReviews($db,$reviews);
    drawFooter();

?>

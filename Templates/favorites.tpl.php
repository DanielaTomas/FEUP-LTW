
<?php function drawFavorites(PDO $db, Session $session, array $favorites) {
require_once("../Classes/favorites.class.php");
require_once("../Classes/restaurant.class.php");
require_once("../Classes/dish.class.php");
?>
    <h2>Favorites</h2>
    <?php if(sizeof($favorites) <= 0){?>
        <section>
        <p>You don't have any favorite restaurant or dishes yet &#128542;</p>
        </section>
    <?php } else{ ?>
    <div id="fav">
        <h3>Favorite Restaurants</h3>
        <?php if(isset($_SESSION['id'])){
            for($i = 0; $i < sizeof($favorites); $i++){
                if($favorites[$i]->userid === $session::getId() && Favorites::verifyFavoriteR($db,$favorites[$i]->userid)) {?>
                 <?php
                    $fav = Favorites::getFavoriteR($db,$favorites[$i]->userid);
                    $restaurant = Restaurant::getRestaurant($db, $fav[$i]);?>
                    <p><a href="restaurant.php?id=<?=$restaurant->id?>"><?= $restaurant->name; ?></a><br></p>
               <?php } ?>
           <?php } ?> 
        

        <h3>Favorite Dishes</h3>
           <?php
           $fav2 = Favorites::getFavoriteD($db,$session::getId());
           for($i = 0; $i < sizeof($favorites); $i++){ 
            if($favorites[$i]->userid === $session::getId() && Favorites::verifyFavoriteD($db,$favorites[$i]->userid)) {
                if($i < sizeof($fav2)){
                    $aux2 = Dish::getDish($db, $fav2[$i])?>
                    <section id="dish">
                    <p><a href="dish.php?id=<?=$aux2->id?>"><?= $aux2->name ?></a><br></p>
                    </section>
                <?php } ?>
            <?php } ?>
            </div>
        <?php }
        }
        else{
            header('Location: ../Pages/info.php');
        }
    }
}?>

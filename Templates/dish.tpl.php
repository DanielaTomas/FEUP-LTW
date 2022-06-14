<?php
declare(strict_types=1);
require_once("../Database/connection.db.php");
?>
<?php function drawDish(Session $session, int $restaurantId, string $restaurantName, Dish $dish)
{ ?>
  <h2><a href="restaurant.php?id=<?= $restaurantId ?>"><?= $restaurantName ?></a></h2>
  <section id="dishes" data-id=<?=$dish->id?>>
    <img src="<?=$dish->image?>">
    <h3><?= $dish->name ?></h3>
    <form action="../Actions/action_favorites.php?userid=<?= $session::getId()?>&rid=<?=$restaurantId?>&did=<?=$dish->id?>&option=3" method="post" class="addfavorite">
    <button type="submit">Add Favorite</button>
    </form>
    <form action="../Actions/action_favorites.php?userid=<?= $session::getId()?>&rid=<?=$restaurantId?>&did=<?=$dish->id?>&option=4" method="post" class="removefavorite">
    <button type="submit">Remove Favorite</button>
  </form>
    <p><?= $dish->description ?></p>
    <p><span class="price"><?=$dish->price?></span></p>
  </section>
  <?php drawAddToCart($restaurantId, $dish->id) ?>
<?php } ?>

<?php function drawAddToCart(int $restaurantId, int $dishId)
{ ?>
<section id="dishOrder">
  <form action="../Pages/order.php" method="post">
    <input id="quantity"class="quantity" name="quant" type="number" value="1" min="1" max="100" step="1">
    <button type="submit" class="addtocart" id="addtocart" onclick="addOrder(<?= $restaurantId ?>, <?= $dishId ?>)">Add to Cart</button>
  </form>
</section>
<?php } ?>
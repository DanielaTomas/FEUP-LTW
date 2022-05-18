<?php

declare(strict_types=1); ?>

<?php function drawDish(int $restaurantId, string $restaurantName, Dish $dish)
{ ?>
  <h2><a href="restaurant.php?id=<?= $restaurantId ?>"><?= $restaurantName ?></a></h2>
  <section id="dishes">
    <img src="https://picsum.photos/200?<?= $dish->id?>">
    <h3><?= $dish->name ?></h3>
    <p><?= $dish->description ?></p>
    <p><span><?=$dish->price?></span></p>
  </section>
  <?php drawAddToCart() ?>
<?php } ?>

<?php function drawAddToCart()
{ ?>
  <form action="" method="post">
    <input name="n" type="number" value="1" min="1" max="100" step="1">
    <input type="submit" value="Add to cart">
  </form>
<?php } ?>
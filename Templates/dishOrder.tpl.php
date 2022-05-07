<?php

declare(strict_types=1); ?>

<?php function drawDish(int $restaurantId, string $restaurantName, int $dishId, string $dishName, string $description, float $price)
{ ?>
  <h2><a href="../Classes/restaurant.php?id=<?= $restaurantId ?>"><?= $restaurantName ?></a></h2>
  <section id="dishes">
    <img src="https://picsum.photos/200?<?= $dishId ?>">
    <h3><?= $dishName ?></h3>
    <p><?= $description ?></p>
    <p><span><?=$price?></span></p>
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
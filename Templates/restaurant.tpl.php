<?php declare(strict_types = 1); ?>

<?php function drawRestaurants(array $restaurants) { ?>
  <h2>Restaurants</h2>
  <section id="restaurants">
    <?php foreach($restaurants as $restaurant) { ?> 
      <article>
        <img src="https://picsum.photos/200?<?=$restaurant['id']?>">
        <a href="../Classes/restaurant.php?id=1"><?=$restaurant['name']?></a>
      </article>
    <?php } ?>
  </section>
<?php } ?>

<?php function drawRestaurant(string $restaurantName, array $menus, array $dishes) { ?>
  <h2><?=$restaurantName?></h2>
  <section id="menus">
    <?php foreach ($menus as $menu) { ?>
    <article>
      <h3><?=$menu['name']?></h3>
      <?php foreach ($dishes as $dish) { ?>
       <?php if($dish['menuId'] === $menu['id']) { ?>
        <a href="../Classes/dishOrder.php?id=1"><?=$dish['name']?></a>
        <img src="https://picsum.photos/200?<?=$dish['id']?>">
       <?php } ?>
      <?php } ?>
    </article>
    <?php } ?>
   </section> 
<?php } ?>
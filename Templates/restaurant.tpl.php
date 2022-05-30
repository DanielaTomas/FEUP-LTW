<?php declare(strict_types = 1); ?>

<?php function drawRestaurants(array $restaurants) { ?>
  <h2>Restaurants</h2>
  <section id="restaurants">
    <?php foreach($restaurants as $restaurant) { ?> 
      <article>
        <img src="<?=$restaurant->image?>"/>
        <a href="restaurant.php?id=<?=$restaurant->id?>"><?=$restaurant->name?></a>
      </article>
    <?php } ?>
  </section>
<?php } ?>

<?php function drawRestaurant(string $restaurantName, array $menus, array $dishes) { ?>
  <h2><?=$restaurantName?></h2>
  <section id="menus">
    <?php foreach ($menus as $menu) { ?>
    <article>
      <h3><?=$menu->name?></h3>
      <?php for($i = 0; $i < count($dishes); $i++){ ?>
      <?php foreach ($dishes[$i] as $dish) { ?>
       <?php if($dish->menu === $menu->id) { ?>
        <a href="dish.php?id=<?=$dish->id?>"><?=$dish->name?></a>
        <img src="https://picsum.photos/200?<?=$dish->id?>">
       <?php } ?>
      <?php } ?>
       <?php } ?>
    </article>
    <?php } ?>
   </section> 
<?php } ?>
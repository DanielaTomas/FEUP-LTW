<?php declare(strict_types = 1); ?>

<?php function drawRestaurants(array $restaurants) { ?>
  <img id="search" src='../Docs/search.png'><input id="searchrestaurant" type="text" placeholder="search">
  <h2>Restaurants</h2>
  <section id="restaurants">
    <?php foreach($restaurants as $restaurant) { ?> 
      <article>
        <a href="restaurant.php?id=<?=$restaurant->id?>"><img src="<?=$restaurant->image?>"/></a>
        <a href="restaurant.php?id=<?=$restaurant->id?>"><?=$restaurant->name?></a>
      </article>
    <?php } ?>
  </section>
<?php } ?>

<?php function drawRestaurant(Session $session, Restaurant $restaurant, array $menus, array $dishes) { ?>
  <h2><?=$restaurant->name?></h2>
  <section id="menus">
    <?php foreach ($menus as $menu) { ?>
    <article>
      <h3><?=$menu->name?></h3>
      <?php for($i = 0; $i < count($dishes); $i++){ ?>
      <?php foreach ($dishes[$i] as $dish) { ?>
       <?php if($dish->menu === $menu->id) { ?>
        <a href="dish.php?id=<?=$dish->id?>"><?=$dish->name?></a>
        <img src="<?=$dish->image?>">
       <?php } ?>
      <?php } ?>
       <?php } ?>
    </article>
    <?php } ?>
   </section> 
   <?php 
   $user = $session::getUsername(); 
    if($user) { ?>
   <a href="../Pages/review.php?id=<?=$restaurant->id?>"><img id="reviewIcon" src="../Docs/review.png"></a> 
   <?php } ?>
<?php } ?>
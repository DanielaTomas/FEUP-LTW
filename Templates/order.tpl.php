<?php

declare(strict_types=1);
?>

<?php function drawCart(array $orders, int $id) { ?>
<?php 
  require_once("../Database/connection.db.php");
  require_once("../Classes/restaurant.class.php");
  require_once("../Classes/order.class.php");
  $db = getDatabaseConnection('sqlite:../Database/database.db');
  if(intval($_POST['quant'])){
  Order::addquantity($db, $id, intval($_POST['quant']));
}
  $quantitiesorders = Order::getallquantities($db);
  $ordersUser = [];
  $bill = 0;
?>
  <h2>Orders</h2>
  <section id="shoppingcart">
      <table id="ordersTable">
        <thead></thead>
          <tr><th>Restaurant</th><th>Dish</th><th>Quantity</th><th>Price</th><th>Status</th><th>Total</th><th>Delete</th></tr>
        </thead>
        <tbody>
          <?php for($i = 0; $i < sizeof($orders); $i++){ ?>
            <?php
              $restaurant = Restaurant::getRestaurant($db,$orders[$i]->restaurant);
              $dish = Order::getDishOrder($db,$orders[$i]->id);
              array_push($ordersUser, $orders[$i]->id);
              $total = $quantitiesorders[$i]*$dish->price;
              $bill = $bill + $total;
            ?>
            <tr><td><?= $restaurant->name ?></td><td><?= $dish->name ?></td>
                <td><?=$quantitiesorders[$i]?></td><td><?=$dish->price?> €</td>
                <td><?=$orders[$i]->status?></td><td><?=$total?> €</td>
                <td><a href="../Actions/action_delete_order.php?orderid=<?=$orders[$i]->id?>"><input type="submit" value="Cancel" onclick="deleteRow(this)"></a></td>
            </tr>
          <?php } ?>
        </tbody>
        <tfoot>
          <tr><th colspan="7">Total: <?=$bill?> €</th></tr>
        </tfoot>
      </table>
  </section>
<?php } ?>
<?php
declare(strict_types=1);
?>

<?php function drawCart(PDO $db, Session $session, array $orders) { ?>
<?php 
  require_once("../Classes/restaurant.class.php");
  require_once("../Classes/order.class.php");
  $bill = 0;
?>
  <h2>Orders</h2>
  <?php if(isset($_SESSION['id'])){ ?>
  <section id="shoppingcart">
      <table id="ordersTable">
        <thead></thead>
          <tr><th>Restaurant</th><th>Dish</th><th>Quantity</th><th>Price</th><th>Status</th><th>Total</th><th>Delete</th></tr>
        </thead>
        <tbody>
          <?php for($i = 0; $i < sizeof($orders); $i++){ ?>
            <?php if($session::getId() === $orders[$i]->userid) {
                      $restaurant = Restaurant::getRestaurant($db,$orders[$i]->restaurant);
                      $dish = Order::getDishOrder($db,$orders[$i]->id);
                      $total = $orders[$i]->quantity*$dish->price;
                      $bill = $bill + $total;
                    ?>
                    <tr><td><?= $restaurant->name ?></td><td><?= $dish->name ?></td>
                        <td><?= $orders[$i]->quantity ?></td><td><?=$dish->price?> €</td>
                        <td><?=$orders[$i]->status?></td><td><?=$total?> €</td>
                        <td><input type="submit" value="X" id="cancel" onclick="deleteOrder(this,<?= $orders[$i]->id ?>)"></a></td>
                    </tr>
            <?php }
          }?>
        </tbody>
        <tfoot>
          <tr><th colspan="7">Total: <?=$bill?> €</th></tr>
        </tfoot>
      </table>
      <div class="finish">
        <?php
        $aux = json_encode($orders); 
        $ordersfinal = urlencode($aux);
        ?>
        <a href="../Actions/action_change_status.php?ordersfinal=<?=$ordersfinal?>"><button type="submit" id="finish">Finish Request</button>
      </div>
  </section>
  <?php }
  else{
    header('Location: ../Pages/info.php');
  }?>
<?php } ?>
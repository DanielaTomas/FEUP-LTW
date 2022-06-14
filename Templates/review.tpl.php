<?php

declare(strict_types=1); ?>

<?php function drawReview(Restaurant $restaurant)
{ ?>
  <h2>Send Your Feedback!</h2>   
     <!--   <div class="alert" id="success">
          <a href="#" class="close" data-dismiss="alert"></a>
        </div> -->
        <div class="rate"> 
            <h2>What do you think about <a href="../Pages/restaurant.php?id=<?=$restaurant->id?>"><span id=reviewRestaurantName><?= "$restaurant->name" ?></span></a> restaurant?</h2>
            <h3>Rate:</h3>
            <form class="reviewForm" name="form1" method="post">
              <select name="score" class="form" id="score">
                  <option value="1">1</option>
                  <option value="2">2</option>
                  <option value="3">3</option>
                  <option value="4">4</option>
                  <option value="5">5</option>
              </select>
              <h3>Leave a Comment:</h3>
              <textarea class="reviewText" id="reviewText" rows="5" cols="60"></textarea></br>
              <button type="submit" id="submitReview">Submit</button>
            </form>
        </div>
    <script src = "https://code.jquery.com/jquery-3.5.1.min.js" > </script>

<?php } ?>


<?php function drawReviews(PDO $db,array $reviews)
{ ?>
  <h2>See what other users think:</h2>
    <?php 
    require_once('../Classes/user.class.php'); 
    $count = 0;
     for($i = 0; $i < sizeof($reviews); $i++){ 
      $user = User::getUser($db,$reviews[$i]->userId);
      ?>
        <div id="userReview">
          <p>
            <span id=reviewUsername><?= $user->username?></span>
            <?php for($j = 0; $j < intval($reviews[$i]->score); $j++) { ?>
                &#11088;
            <?php } ?>
            <?php $count += $reviews[$i]->score ?>
            <?= $reviews[$i]->reviewText?>
          </p>
        </div>
          
       <?php } ?>
       <?php if(sizeof($reviews) > 0) { ?>
          <div id="restaurantReview">
            <?php 
            $average = round($count/(sizeof($reviews)),2) ?>
            &#11088;<?= $average ?>
            <?="("?><?= sizeof($reviews) ?><?=")"?>
          </div>
       <?php } 
       else { ?>
        <div id="userReview">
          <p>There are no reviews yet &#128542;</p>
       </div>
        <?php } ?>
<?php } ?>
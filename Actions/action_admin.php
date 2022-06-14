<?php
  declare(strict_types = 1); 

  require_once('../Classes/session.class.php');
  $session = new Session();
  require_once('../Database/connection.db.php');
  require_once('../Templates/admin.tpl.php');
  require_once('../Classes/user.class.php');
  require_once('../Classes/admin.class.php');
  $db = getDatabaseConnection('sqlite:../Database/database.db');
  $option = $_GET['option'];
  require_once('../Templates/common.tpl.php');
  drawHeader($session);
?>
  <form action="" method="post" class="adminoptions">

    <?php if($option == 1 || $option == 10){ ?>
    <p>Administrator Id</p> <input type="number" id="data" name="adminid"><//br>
    <?php } ?>

    <?php if($option == 2 || $option == 3 || $option == 6 || $option == 7 || $option == 11){ ?>
    <p>User Id</p> <input type="number" id="data" name="userid"><//br>
    <?php } ?>

    <?php if($option == 2 || $option == 6){ ?>
    <p>User Name</p> <input type="text" id="data" name="username"><//br>
    <p>User Username</p> <input type="text" id="data" name="userusername"><//br>
    <p>User Password</p> <input type="password" id="data" name="userpassword"><//br>
    <p>User Phone Number</p> <input type="number" id="data" name="userphonenumber"><//br>
    <p>User Address</p> <input type="text" id="data" name="useraddress"><//br>
    <?php } ?>

    <?php if($option == 2 || $option == 3 || $option == 4 || $option == 6 || $option == 7 || $option == 8 || $option == 12){ ?>
    <p>Restaurant Id</p> <input type="number" id="data" name="restaurantid"><br>
    <?php } ?>

    <?php if($option == 3 || $option == 7){ ?>
    <p>Restaurant Name</p> <input type="text" id="data" name="restaurantname"><br>
    <p>Restaurant Location</p> <input type="text" id="data" name="restaurantaddress"><br>
    <p>Restaurant Category</p> <input type="text" id="data" name="restaurantcategory"><br>
    <p>Restaurant Photo (Link)</p> <input type="text" id="data" name="restaurantphoto"><br>
    <?php } ?>

    <?php if($option == 4 || $option == 5 || $option == 8 || $option == 9 || $option == 13){ ?>
    <p>Menu Id</p> <input type="number" id="data" name="menuid"><br>
    <?php } ?>

    <?php if($option == 4 || $option == 8){ ?>
    <p>Menu Type</p> <input type="text" id="data" name="menutype"><br>
    <?php } ?>

    <?php if($option == 5 || $option == 9 || $option == 14){ ?>
    <p>Dish Id</p> <input type="number" id="data" name="dishid"><br>
    <?php } ?>
    <?php if($option == 5 || $option == 9){ ?>
    <p>Dish Name</p> <input type="text" id="data" name="dishname"><br>
    <p>Dish Price</p> <input type="text" id="data" name="dishprice"><br>
    <p>Dish Description</p> <input type="text" id="data" name="dishdescription"><br>
    <p>Dish Photo (Link)</p> <input type="text" id="data" name="dishphoto"><br>
    <?php } ?>
    <input type="submit" name="submit" value="Submit">
  </form>

  <?php
  if(isset($_POST['submit'])){
  switch($option){
    case 1:
      If(User::verifyAdmin($db,intval($_POST['adminid'])) == False){
      Admin::addAdmin($db, intval($_POST['adminid']));
      }
      header('Location: ../Pages/adminoperation.php');
      break;
    case 2:
      Admin::addUser($db, intval($_POST['userid']), $_POST['username'], $_POST['userusername'], $_POST['userpassword'], $_POST['useraddress'], intval($_POST['userphonenumber']), intval($_POST['restaurantid']));
      header('Location: ../Pages/adminoperation.php');
      break;
    case 3:
      Admin::addRestaurant($db, intval($_POST['restaurantid']), $_POST['restaurantname'], $_POST['restaurantaddress'], $_POST['restaurantcategory'], $_POST['restaurantphoto'], intval($_POST['userid']));
      header('Location: ../Pages/adminoperation.php');
      break;
    case 4:
      Admin::addMenu($db, intval($_POST['menuid']), $_POST['menutype'], intval($_POST['restaurantid']));
      header('Location: ../Pages/adminoperation.php');
      break;
    case 5:
      Admin::addDish($db, intval($_POST['dishid']), $_POST['dishname'], floatval($_POST['dishprice']), $_POST['dishdescription'], intval($_POST['menuid']), $_POST['dishphoto']);
      header('Location: ../Pages/adminoperation.php');
      break;
    case 6:
      Admin::updateUser($db, intval($_POST['userid']), $_POST['username'], $_POST['userusername'], $_POST['userpassword'], $_POST['useraddress'], intval($_POST['userphonenumber']), intval($_POST['restaurantid']));
      header('Location: ../Pages/adminoperation.php');
      break;
    case 7:
      Admin::updateRestaurant($db, intval($_POST['restaurantid']), $_POST['restaurantname'], $_POST['restaurantaddress'], $_POST['restaurantcategory'], $_POST['restaurantphoto'], intval($_POST['userid']));
      header('Location: ../Pages/adminoperation.php');
      break;
    case 8:
      Admin::updateMenu($db, intval($_POST['menuid']), $_POST['menutype'], intval($_POST['restaurantid']));
      header('Location: ../Pages/adminoperation.php');
      break;
    case 9:
      Admin::updateDish($db, intval($_POST['dishid']), $_POST['dishname'], floatval($_POST['dishprice']), $_POST['dishdescription'], intval($_POST['menuid']), $_POST['dishphoto']);
      header('Location: ../Pages/adminoperation.php');
      break;
    case 10:
      Admin::removeAdmin($db, intval($_POST['adminid']));
      header('Location: ../Pages/adminoperation.php');
      break;
    case 11:
      Admin::removeUser($db, intval($_POST['userid']));
      header('Location: ../Pages/adminoperation.php');
      break;
    case 12:
      Admin::removeRestaurant($db, intval($_POST['restaurantid']));
      header('Location: ../Pages/adminoperation.php');
      break;
    case 13:
      Admin::removeMenu($db, intval($_POST['menuid']));
      header('Location: ../Pages/adminoperation.php');
      break;
    case 14:
      Admin::removeDish($db, intval($_POST['dishid']));
      header('Location: ../Pages/adminoperation.php');
      break;
    }
  }
drawFooter();
?>
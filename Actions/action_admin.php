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
  ?>
  <form action="" method="post">

    <?php if($option == 1 || $option == 10){ ?>
    Administrator Id <input type="number" id="data" name="adminid" value=0><br>
    <?php } ?>

    <?php if($option == 2 || $option == 3 || $option == 6 || $option == 7 || $option == 11){ ?>
    User Id <input type="number" id="data" name="userid" value=0><br>
    <?php } ?>

    <?php if($option == 2 || $option == 6){ ?>
    User Name <input type="text" id="data" name="username"><br>
    User Username <input type="text" id="data" name="userusername"><br>
    User Password <input type="password" id="data" name="userpassword"><br>
    User Phone Number <input type="number" id="data" name="userphonenumber"><br>
    User Address <input type="text" id="data" name="useraddress"><br>
    <?php } ?>

    <?php if($option == 2 || $option == 3 || $option == 4 || $option == 6 || $option == 7 || $option == 8 || $option == 11 || $option == 12 || $option == 13){ ?>
    Restaurant Id <input type="number" id="data" name="restaurantid"><br>
    <?php } ?>

    <?php if($option == 3 || $option == 7){ ?>
    Restaurant Name <input type="text" id="data" name="restaurantname"><br>
    Restaurant Location <input type="text" id="data" name="restaurantaddress"><br>
    Restaurant Category <input type="text" id="data" name="restaurantcategory"><br>
    Restaurant Photo (Link) <input type="text" id="data" name="restaurantphoto"><br>
    <?php } ?>

    <?php if($option == 4 || $option == 5 || $option == 8 || $option == 9 || $option == 13 || $option == 14){ ?>
    Menu Id <input type="number" id="data" name="menuid"><br>
    <?php } ?>

    <?php if($option == 4 || $option == 8){ ?>
    Menu Type <input type="text" id="data" name="menutype"><br>
    <?php } ?>

    <?php if($option == 5 || $option == 9 || $option == 14){ ?>
    Dish Id <input type="number" id="data" name="dishid"><br>
    <?php } ?>
    <?php if($option == 5 || $option == 9){ ?>
    Dish Name <input type="text" id="data" name="dishname"><br>
    Dish Price <input type="text" id="data" name="dishprice"><br>
    Dish Description <input type="text" id="data" name="dishdescription"><br>
    Dish Photo (Link) <input type="text" id="data" name="dishphoto"><br>
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
?>
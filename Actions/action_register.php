<?php
 require_once('../Database/connection.db.php');
 require_once('../Classes/user.class.php');

 $db = getDatabaseConnection('sqlite:../Database/database.db');
 $id = User::maxid($db);
 User::registerUser($db, $id, $_POST['registerfirstlastname'], $_POST['registerusername'], sha1($_POST['registerpassword']), $_POST['registeraddress'],  strval($_POST['registerphonenumber']), 1);

 header('Location: ../Pages/index.php');

?>
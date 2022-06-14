<?php
    require_once('../Templates/common.tpl.php');
    require_once('../Classes/session.class.php');
    $session = new Session();
    drawHeader($session);
?>
    <body>
        <h2>Registration<br></h2>
        <div id="registration">
          <form action="../Actions/action_register.php" method="post">
              <label for="registerfirstlastname"><p>First and Last Name</p></label>
              <input type="text" name="registerfirstlastname" required>

              <label for="registeraddress"><p>Address</p></label>
              <input type="text" name="registeraddress" required>

              <label for="registerphonenumber"><p>Phone Number</p></label>
              <input type="number" name="registerphonenumber" required>

              <label for="registerusername"><p>Username</p></label>
              <input type="text" name="registerusername" required>

              <label for="registerpassword"><p>Password</p></label>
              <input type="password" name="registerpassword" required>
              <br><br><button type="submit" id="register" name="register" value="Register">Submit</button>
              
          </form>
        </div>
    </body>
    <?php
      drawFooter();
    ?>
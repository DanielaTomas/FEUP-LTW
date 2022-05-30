    
     <?php
      require_once('../Templates/common.tpl.php');
      session_start();
      drawHeader('../Css/style.css', 'index.php', '../Actions/action_login.php', '../Actions/action_logout.php');
      ?>
    <body>
        <strong>Registration<br></strong>
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

            <input type="submit" name="register" value="Register">
        </form>
    </body>
    <?php
      drawFooter();
    ?>
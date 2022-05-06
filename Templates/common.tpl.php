<?php declare(strict_types = 1); ?>

<?php function drawHeader() { ?>
<!DOCTYPE html>
<html lang="en-US">
<head>
    <title>Restaurants Website</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width">
    <link rel="stylesheet" href="../Css/style.css">
  </head>
  <body>

    <header>
      <h1><a href="/">Restaurants Website</a></h1>
      <?php drawLoginForm() ?>
    </header>
  
    <main>
<?php } ?>

<?php function drawLoginForm() { ?>
  <form action="login.php" method="post" class="login">
        <input type="text" name="username" placeholder="username">
        <input type="password" name="password" placeholder="password">
        <a href="register.php">Register</a>
        <button type="submit">Login</button>
  </form>
<?php } ?>

<?php function drawFooter() { ?>
    </main>

    <footer>
      LTW Project &copy; 2022
    </footer>
  </body>
</html>
<?php } ?>
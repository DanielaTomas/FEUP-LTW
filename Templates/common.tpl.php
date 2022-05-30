<?php declare(strict_types = 1); ?>

<?php function drawHeader(string $css, string $index, string $pathlogin, string $pathlogout) { ?>
<!DOCTYPE html>
<html lang="en-US">
<head>
    <title>Meet & Eat</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width">
    <link rel="stylesheet" href=<?php echo ($css); ?>>
    <link rel="icon" type="image/ico" href="https://cdn.discordapp.com/attachments/937461518197461044/978375318630985738/logo.png" alt="logo">
  </head>
  <body>

    <header>
      <a href=<?php echo($index); ?>><img id="logo" src="https://cdn.discordapp.com/attachments/937461518197461044/978375318630985738/logo.png" alt="logo"></a>
      <h1><a href=<?php echo ($index); ?>>Meet & Eat</a></h1>
      <?php if (isset($_SESSION['id'])) drawLogoutForm($_SESSION['username'], $pathlogout);
        else drawLoginForm($pathlogin); ?>
    </header>

    <main>
<?php } ?>

<?php function drawLoginForm(string $path) { ?>
  <form action=<?php echo ($path); ?> method="post" class="login">
        <input type="text" name="username" placeholder="username">
        <input type="password" name="password" placeholder="password">
        <a href="register.php">Register</a>
        <button type="submit">Login</button>
  </form>
<?php } ?>

<?php function drawLogoutForm(string $username, string $path) { ?>
  <form action=<?php echo ($path); ?> method="post" class="logout">
    <a href="../Pages/profile.php"><?=$username?></a>
    <button type="submit">Logout</button>
  </form>
<?php } ?>

<?php function drawFooter() { ?>
    <a href="../Pages/order.php"><img id="cartIcon" src="https://ayudawp.com/wp-content/uploads/2020/04/icono-anadir-al-carrito.png"></a>
    </main>

    <footer>
      LTW Project &copy 2022
    </footer>
  </body>
</html>
<?php } ?>
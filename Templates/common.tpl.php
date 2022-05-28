<?php declare(strict_types = 1); ?>

<?php function drawHeader() { ?>
<!DOCTYPE html>
<html lang="en-US">
<head>
    <title>Meet & Eat</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width">
    <link rel="stylesheet" href="Css/style.css">
    <link rel="icon" type="image/ico" href="https://cdn.discordapp.com/attachments/937461518197461044/978375318630985738/logo.png">
  </head>
  <body>

    <header>
      <h1><a href="index.php">Meet & Eat</a></h1>
      <?php if (isset($_SESSION['id'])) drawLogoutForm($_SESSION['username']);
        else drawLoginForm(); ?>
    </header>
  
    <main>
<?php } ?>

<?php function drawLoginForm() { ?>
  <form action="action_login.php" method="post" class="login">
        <input type="text" name="username" placeholder="username">
        <input type="password" name="password" placeholder="password">
        <a href="register.php">Register</a>
        <button type="submit">Login</button>
  </form>
<?php } ?>

<?php function drawLogoutForm(string $username) { ?>
  <form action="action_logout.php" method="post" class="logout">
    <a href="profile.php"><?=$username?></a>
    <button type="submit">Logout</button>
  </form>
<?php } ?>

<?php function drawFooter() { ?>
    </main>

    <footer>
      LTW Project &copy 2022
    </footer>
  </body>
</html>
<?php } ?>
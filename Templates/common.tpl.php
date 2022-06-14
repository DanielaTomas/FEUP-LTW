<?php declare(strict_types = 1); 
?>

<?php function drawHeader(Session $session) { ?>
<!DOCTYPE html>
<html lang="en-US">
<head>
    <title>Meet & Eat</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width">
    <link rel="stylesheet" href='../Css/style.css'>
    <link rel="icon" type="image/ico" href="../Docs/logo.png" alt="logo">
    <script src="../Javascript/script.js" defer></script>
  </head>
  <body>

    <header>
      <a href='index.php'><img id="logo" src="../Docs/logo.png" alt="logo"></a>
      <h1><a href='index.php'>Meet & Eat</a></h1>
      <?php if ($session::login()) drawLogoutForm($session::getUsername(), '../Actions/action_logout.php');
        else drawLoginForm('../Actions/action_login.php'); ?>
    </header>

    <section id="messages">
      <?php foreach ($session->getMessages() as $message) { ?>
        <article class="<?=$message['type']?>">
          <?=$message['text']?>
        </article>
      <?php } ?>
    </section>
    <main>
    <?php $user = $session::getUsername(); 
    if($user) {?>
     <a href="../Pages/order.php"><img id="cartIcon" src="../Docs/cart.png"></a>
     <a href="../Pages/admin.php"><img id="adminIcon" src="../Docs/admin.png"></a>

    <?php } ?>
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
    </main>

    <footer>
      LTW Project &copy 2022 By Daniela Tomás and Henrique Vicente
    </footer>
  </body>
</html>
<?php } ?>
<?php
require_once('../Classes/session.class.php');
$session = new Session();
require_once('../Templates/common.tpl.php');
drawHeader($session);
?>
<!DOCTYPE html>
<html lang="en-US">
  <head>
    <title>Meet & Eat</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width">
    <link rel="stylesheet" href='../Css/style.css'>
    <link rel="icon" type="image/ico" href="../Docs/logo.png" alt="logo"> 
  </head>

  <body>
    <div id = "info">
      <span>&#9888;</span><p>You must be Logged in. If you don't have an account, you must Register.</p>
      <form action="index.php" method="post">
        <button type="submit" class="home">Home</button>
      </form>
    </div>
  </body>
</html>
<?php
drawFooter();
?>
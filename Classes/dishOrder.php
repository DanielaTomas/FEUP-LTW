<!DOCTYPE html>
<html lang="en-US">
  <head>
    <title>Restaurants Website</title>
    <meta charset="utf-8">
    <link rel="stylesheet" href="../Css/style.css">
  </head>
  <body>

  <header>
      <h1><a href="../index.php">Restaurants Website</a></h1>
      <form action="login.php" method="post" class="login">
        <input type="text" name="username" placeholder="username">
        <input type="password" name="password" placeholder="password">
        <a href="register.php">Register</a>
        <button type="submit">Login</button>
      </form>
    </header>

    <main>
      <img src="https://picsum.photos/200?1">
      <h1>Dish Name</h1>
      <p>Description</p>
      <p><br>Price</p>
      <form action="" method="post">
      <input name="n" type="number" value="1" min="1" max="100" step="1">
      <input type="submit" value="Add to cart">
      </form>
    </main>
    <footer>
      LTW Project &copy; 2022
    </footer>
  </body>
</html>
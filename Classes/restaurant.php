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
      <h2>Restaurant name</h2>
      <section id="menus">
        <article>
          <h3>Menu Name</h3>
          <ul>
          <ul>
            <li><a href="dishOrder.php">Dish Name</a><img src="https://picsum.photos/200?1"></li>
            <li><a href="dishOrder.php">Dish Name</a><img src="https://picsum.photos/200?2"></li>
          </ul>
          </ul>
        </article>

        <article>
        <h3>Menu Name</h3>
        <ul>
            <li><a href="dishOrder.php">Dish Name</a><img src="https://picsum.photos/200?3"></li>
            <li><a href="dishOrder.php">Dish Name</a><img src="https://picsum.photos/200?4"></li>
          </ul>
        </article>

        <article>
        <h3>Menu Name</h3>
        <ul>
            <li><a href="dishOrder.php">Dish Name</a><img src="https://picsum.photos/200?5"></li>
            <li><a href="dishOrder.php">Dish Name</a><img src="https://picsum.photos/200?6"></li>
          </ul>
        </article>
      </section>
    </main>

    <footer>
      LTW Project &copy; 2022
    </footer>
  </body>
</html>
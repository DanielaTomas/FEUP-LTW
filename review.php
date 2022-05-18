<!DOCTYPE html>
<html lang="en-US">
  <head>
    <title>Restaurants Website</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width">
    <link rel="stylesheet" href="Css/style.css">
  </head>
  <body>

  <header>
      <h1><a href="index.php">Restaurants Website</a></h1>
      <form action="action_login.php" method="post" class="login">
        <input type="text" name="username" placeholder="username">
        <input type="password" name="password" placeholder="password">
        <a href="register.php">Register</a>
        <button type="submit">Login</button>
      </form>
    </header>

    <main>
        <h2>Send Your Feedback</h2>   
        <div class="rate"> 
            <h3>Rate</h3>
            <select class="form" id="score">
                <option value="1">1</option>
                <option value="2">2</option>
                <option value="3">3</option>
                <option value="4">4</option>
                <option value="5">5</option>
            </select>
        </div>
        <h3>Leave a Comment</h3>
        <textarea class="form-control" id="review" rows="3"></textarea>
        </div>

        <button type="submit">Submit</button>
    </main>
</body>
</html>
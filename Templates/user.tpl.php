<?php declare(strict_types = 1); ?>

<?php function drawProfileForm(User $user, string $path) { ?>
<h2>Profile</h2>
<form action=<?php echo ($path); ?> method="post" class="profile">

  <label for="first_last_name">First and Last Name:</label>
  <input id="first_last_name" type="text" name="first_last_name" value="<?=$user->firstLastName?>">

  <label for="address">Address:</label>
  <input id="address" type="text" name="address" value="<?=$user->userAddress?>">
  
  <label for="phonenumber">Phone Number:</label>
  <input id="phonenumber" type="number" name="phonenumber" value="<?=$user->phoneNumber?>"> 
  
  <label for="username">Username:</label>
  <input id="username" type="text" name="username" value="<?=$user->username?>">  
  
  <button type="submit">Save</button>
</form>
<?php } ?>
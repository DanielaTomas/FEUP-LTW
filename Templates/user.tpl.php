<?php declare(strict_types = 1); ?>

<?php function drawProfileForm(User $user, string $path) { ?>
<h2>Profile</h2>
<form action="../Pages/edit_profile_button.php?path=<?=$path?>" method="post" class="profile">
  <label for="first_last_name"><p>First and Last Name:</p> <?=$user->firstLastName?><br></label>
  <label for="address"><p>Address:</p> <?=$user->userAddress?><br></label>
  <label for="phonenumber"><p>Phone Number:</p> <?=$user->phoneNumber?><br></label>
  <label for="username"><p>Username:</p> <?=$user->username?><br></label> 
  <button type="submit">Edit</button>
</form>
<?php
} ?>

<?php function drawEditProfileForm(User $user, string $path) { ?>
<h2>Profile</h2>
<form action=<?=$path?> method="post" class="editprofile">
  <label for="first_last_name"><p>First and Last Name:</p></label>
  <input id="first_last_name" type="text" name="first_last_name" value="<?=$user->firstLastName?>">
  <label for="address"><p>Address:</p></label>
  <input id="address" type="text" name="address" value="<?=$user->userAddress?>">
  <label for="phonenumber"><p>Phone Number:</p></label>
  <input id="phonenumber" type="number" name="phonenumber" value="<?=$user->phoneNumber?>"> 
  <label for="username"><p>Username:</p></label>
  <input id="username" type="text" name="username" value="<?=$user->username?>"><br>
  <button type="submit">Save</button>
</form>
<?php } ?>
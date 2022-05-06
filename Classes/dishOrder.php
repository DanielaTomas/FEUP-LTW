<?php
  declare(strict_types = 1);

  require_once('../Templates/common.tpl.php');
  require_once('../Templates/dishOrder.tpl.php');

  drawHeader();
  drawDish(1,'Restaurant Name', 1, 'Dish Name','Description', 0);
  drawFooter(); 
?>
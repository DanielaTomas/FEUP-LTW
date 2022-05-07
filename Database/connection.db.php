<?php
  
  declare(strict_types = 1);

  function getDatabaseConnection(string $path) : PDO {
    $db = new PDO($path);
    $db->setAttribute(PDO::ATTR_DEFAULT_FETCH_MODE, PDO::FETCH_ASSOC);
    $db->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
    return $db;
  }
?>
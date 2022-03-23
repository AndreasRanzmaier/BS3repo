<?php
try
{
  $server = 'localhost';
  $user = 'root';
  $pwd = '';
  $db = 'adresse';

  $con = new PDO('mysql:host='.$server.';
        dbname='.$db.';charset=utf8', $user, $pwd);
  $con->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
} catch(Exception $e)
{
  echo $e->getCode().': '.$e->getMessage().'<br>';
}
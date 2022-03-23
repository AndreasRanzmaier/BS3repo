<?php
// plz_save.php
// Daten speichern
try
{
  // Formulardaten
  $plz = $_POST['plz'];

  $query1 = 'insert into plz (plz_nr) values(?)';
  $stmt1 = $con->prepare($query1);
  // $stmt1->bindParam(1, $plz);
  // $stmt1->execute();
  // alternative Schreibweise
  $stmt1->execute([$plz]);
  echo '<span>PLZ '.$plz.' wurde gespeichert!';
} catch(Exception $e)
{
  echo $e->getCode().': '.$e->getMessage();
}

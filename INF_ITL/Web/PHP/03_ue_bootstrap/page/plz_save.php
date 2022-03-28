<?php
// plz_save.php
// Daten speichern
try
{
  // Formulardaten
  $plz = $_POST['plz'];

  $query2 = 'select * from plz where plz_nr = ? and ort_id is null';
  $stmt2 = $con->prepare($query2);
  $stmt2->execute([$plz]);

  if($stmt2->rowCount() == 0) {
    $query1 = 'insert into plz (plz_nr) values(?)';
    $stmt1 = $con->prepare($query1);
    // $stmt1->bindParam(1, $plz);
    // $stmt1->execute();
    // alternative Schreibweise
    $stmt1->execute([$plz]);
    echo '<span>PLZ ' . $plz . ' wurde gespeichert! Neuer PK '.$con->lastInsertId();
  } else
  {
    echo '<span>Die PLZ '.$plz.' mit ort_id NULL ist bereits vorhanden</span>';
  }
  /* Anschließend Tabelle aller PLZ + Ortsname ausgeben */
  $query3 = 'select plz_nr as "PLZ", ort_name as "Ort" 
from plz left outer join ort using(ort_id) order by plz_nr';
  makeTable($query3);
} catch(Exception $e)
{
  echo $e->getCode().': '.$e->getMessage();
}

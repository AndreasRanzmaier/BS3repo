<?php
//plz_save.php
//Daten speichern
try
{
    $plz = $_POST['plz'];
    $query2 ='select * from plz where plz_nr = ? and ort_id is null';
    $arrayValue = array($plz);
    $stmt2 = makeStatement($query2,$arrayValue);
    if ($stmt2->rowCount() == 0) {
        $query1 = 'insert into plz (plz_nr) value(?)';
        makeStatement($query1,$arrayValue);
        echo '<span>PLZ '.$plz.' wurde gespeichert! Neuer PK '.$con->lastInsertId();
    }
    else {
        echo '<span>Die PLZ '.$plz. ' mit ort_id Null ist bereits vorhanden</span>';
        /*Anschließend Tabelle aller PLZ ausgeben"*/
    }

    $query3 = 'select plz_nr as "PLZ", ort_name as "Ort" 
from plz left outer join ort using(ort_id) order by plz_nr';
    makeTable($query3);
} catch(Exception $e)
{
    echo $e->getCode().': '.$e->getMessage();
}
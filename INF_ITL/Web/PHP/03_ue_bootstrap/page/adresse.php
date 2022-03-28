<?php
echo '<h2>Adressen</h2>';
/* Alle Adressen die Ort UND Strasse "haben" */
try {
  $query = 'select plz_nr as "PLZ", 
                 ort_name as "Ort", 
                 str_name as "Strasse" 
          from ort natural join plz 
                    natural join plz_strasse 
                    natural join strasse 
          order by  plz_nr, ort_name';
  $stmt = $con->prepare($query);
  $stmt->execute();
  /* Spaltenbezeichnung dynamisch erzeugen */
  $meta = array();
  echo '<table>
        <tr>';
  for($i = 0; $i < $stmt->columnCount(); $i++)
  {
    $meta[] = $stmt->getColumnMeta($i);
    echo '<th>'.$meta[$i]['name'].'</th>';
  }
  echo '</tr>';
  while($row = $stmt->fetch(PDO::FETCH_NUM))
  {
    echo '<tr>';
    foreach($row as $r)
    {
      echo '<td>'.$r.'</td>';
    }
    // alternative ohne foreach
    /*
    echo '<td>'.$row[0].'</td>
      <td>'.$row[1].'</td>
      <td>'.$row[2].'</td>';
    */
    echo '</tr>';
  }
  echo '</table>';
} catch(Exception $e)
{
  echo $e->getCode().': '.$e->getMessage().'<br>';
}
<?php
if(isset($_POST['save']))
{
  // Ort speichern
  try {

    $ort = $_POST['ort'];
    $plzid = $_POST['plz'];
    $query1 = 'insert into ort (ort_name) values(?)';
    $query2 = 'update plz set ort_id=? where plz_id=?';

    $stmt1 = $con->prepare($query1);
    $stmt1->execute([$ort]);

    $ortid = $con->lastInsertId();
    $stmt2 = $con->prepare($query2);
    $stmt2->execute([$ortid, $plzid]);
    echo 'Der neue Ort wurde erfasst';
  } catch (Exception $e)
  {
    echo $e->getCode().': '.$e->getMessage().'<br>';
  }
} else
{
  // Formular anzeigen
  ?>
  <form method="post">
    <label for="ort">Ortsname:</label>
    <input type="text" id="ort" name="ort" required placeholder="z.B. Linz">
    <br>
    <?php
    /* Abfrage auf ord_id is null, ansonsten würde bei der ersten Übereinstimmung
       bei einer bestehende Verknüpfung von Ort und PLZ, die ort_id überschrieben.
       Es werden somit nur PLZ angezeigt, denen noch kein Ort zugeordnet wurde
    */
    $query = 'select * from plz where ort_id is null order by plz_nr';
    $stmt = $con->prepare($query);
    $stmt->execute();
    echo '<label>PLZ</label>';
    echo '<select name="plz">';
    while($row = $stmt->fetch(PDO::FETCH_NUM))
    {
      echo '<option value="'.$row[0].'">'.$row[2];
    }
    echo '</select><br>';
    ?>
    <input type="submit" name="save" value="speichern">
  </form>
<?php
}

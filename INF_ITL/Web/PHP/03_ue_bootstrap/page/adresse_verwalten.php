<?php
if(isset($_POST['save']))
{
  ?>
  <form method="post">
    <label for="str">Straßenname:</label>
    <input type="text" id="str" name="strasse" placeholder="z.B. Wiener Straße" required>
    <?php
    $query1 = 'select plz_id, plz_nr, ort_name from ort natural join plz';
    $stmt1 = $con->prepare($query1);
    $stmt1->execute();
    echo '<label for="ort">PLZ und Ort auswählen:</label>
          <select id="ort" name="ort">';
    while($row = $stmt1->fetch(PDO::FETCH_NUM))
    {
      echo '<option value="'.$row[0].'">'.$row[1].' '.$row[2];
    }
    echo '</select>';

    ?>
    <input type="submit" name="save" value="saveit">
  </form>
  <?php
} else if(isset($_POST['change']))
{

} else
{
  ?>

<?php
}

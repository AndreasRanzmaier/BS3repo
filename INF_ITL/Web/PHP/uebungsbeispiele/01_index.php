<!doctype html>
<html>
<head>
  <title>Eine PHP Seite</title>
</head>
<body>
<main>
  <?php
  // PHP Bereich geöffnet
  /* hier php-Source-Code schreiben
     und auch HTML integrieren
  */
  $value = 5;
  echo $value;
  echo "<br>Die Variable hat den Wert $value<br>";
  echo 'value = '.$value.'!';
  $value = "Mein Text";
  echo '<br>Jetzt ist value = '.$value.'<br>';
  // Variablenwert farbig ausgeben
  echo 'Der Wert der Variablen value= 
    <span style="color:red">'.$value.'</span><br>';
  echo "Wert = <span style=\"color:blue\">$value</span><br>";
  ?>
  <p>Die Variable = <?php echo $value; ?></p>
  <?php
  $value++;
  echo 'Value hat nach ++ den Wert '.$value.'<br>';
  /* Aufgabe: eine beliebige Variable deklarieren und
        initialisieren.
    Je eine Anweisung
    - if-else if - else
    - while
    - do-while
    - for
  */
  $zahl = 0;
  while($zahl < 10)
  {
    $zahl++;
  }
  // alternative Schreibweise
  $zahl = 0;
  while($zahl < 10):
    $zahl++;
  endwhile;
  echo '<br>';
  do
  {
    if($zahl%2 == 0)
    {
      echo "gerade Zahl ".$zahl.'<br>';
    } else if($zahl == 15)
    {
      echo "Zahl = ".$zahl.'<br>';
    } else
    {
      echo $zahl.'<br>';
    }
    $zahl++;
  } while($zahl < 20);
  // alternative Schreibweise
  do
  {
    if($zahl%2 == 0):
      echo "gerade Zahl ".$zahl.'<br>';
    elseif($zahl == 15):
      echo "Zahl = ".$zahl.'<br>';
    else:
      echo $zahl.'<br>';
    endif;
    $zahl++;
  } while($zahl < 20);
  echo '<br>';
  for($i = 0; $i < $zahl; $i++)
  {
    echo $i.' ';
  }
  echo '<br>';
  // alternative Schreibweise
  for($i = 0; $i < $zahl; $i++):
    echo $i.' ';
  endfor;
  echo '<br>';
  echo '<br><h2>Array</h2><br>';
  $myarray = array(1, 2, 3);
  $aarray = [10, 11, 12];
  echo 'myarray[0] = '.$myarray[0].'<br>';
  foreach($aarray as $a)
  {
    echo $a.' ';
  }
  echo '<br>';
  ?>

</main>
</body>
</html>


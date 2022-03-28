<?php
/* R. Martl, 28.3.22, funktionen.php */
function makeStatement($query, $array = null)
{
  global $con;
  $stmt = $con->prepare($query);
  if($array != null)
  {
    $stmt->execute($array);
  } else
  {
    $stmt->execute();
  }
  return $stmt;
}

function makeTable($query, $array = null)
{
  if($array != null)
  {
    $stmt = makeStatement($query, $array);
  } else
  {
    $stmt = makeStatement($query);
  }
  global $con;
  $meta = array();
  echo '<table class="table">
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
    echo '</tr>';
  }
  echo '</table>';
}
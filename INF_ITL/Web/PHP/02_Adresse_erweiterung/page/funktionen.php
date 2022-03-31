<?php
function makeStatement($query, $array = null)
{
    global $con;
    $stmt = $con->prepare($query);
    if($array != null)
    {
        $stmt->execute($array);
    }
    else
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
    }
    else
    {
        $stmt = makeStatement($query);
    }
    global $con;
    $meta = array();
    echo '<table class="table">
          <tr>';
    for($i = 0; $i < $stmt->columnCount();$i++)
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
    echo'</table>';
}
function makeTable2($query, $array = null)
{
    global $con;
    if($array != null)
    {
        $stmt = makeStatement($query, $array);
    }
    else
    {
        $stmt = makeStatement($query);
    }
    $meta = array();
    echo '<table class="table">
          <tr>';
    for($i = 0; $i < $stmt->columnCount(); $i++)
    {
        $meta[] = $stmt->getColumnMeta($i);
        echo '<th>'.$meta[$i]['name'].'</th>';
    }
    echo '<th>Del</th>';
    echo '</tr>';
    $i = 1;
    $myName = "del".$i;
    while($row = $stmt->fetch(PDO::FETCH_NUM))
    {
        echo '<tr>';
        /*foreach($row as $r)
        {
            echo '<td>'.$r.'</td>';
        }
        returnCheckbox($i, $row[0]);
        $i++;*/
        echo '<td>'.$row[0].'</td>';
        echo '<td>'.$row[1].'</td>';
        echo '<td>';
        echo '<input type="checkbox" id="myCheckbox" name="myArray[]" value="'.$row[0].'">';
        echo '</td>';
    }
    echo '</tr>';
    echo '</table>';
}
function returnCheckbox($myName, $inputValue)
{
    echo '<td>';
    echo '<input type="checkbox" id="'.$myName.'" name="'.$myName.'" value="'.$inputValue.'">';
    echo '</td>';
}
<?php
echo '<h2>Adresse</h2>';
try {
    $query = 'select plz_nr as "PLZ",  ort_name as "Ort", str_name as "Strasse"
            from ort left join plz using (ort_id)
                 left join plz_strasse using (plz_id)
                 left join strasse using (str_id)
            where plz_id is not null
             order by plz_nr, ort_name';
    $stmt = $con->prepare($query);
    $stmt->execute();

    $meta = array();
    echo'<table>                   
         <tr>';
    for($i=0;$i<$stmt->columnCount();$i++)
    {
        $meta[]=$stmt->getColumnMeta($i);
        echo '<th>'.$meta[$i]['name'].'</th>';
    }
    echo '</tr>';
    while($row = $stmt->fetch(PDO::FETCH_NUM))
    {
        echo'<tr>';
        foreach ($row as $r)
        {
            echo '<td>'.$r.'</td>';
        }
        echo'</tr>';
    }
}catch(Exception $e)
{
    echo $e->getCode().': '.$e->getMessage();
}
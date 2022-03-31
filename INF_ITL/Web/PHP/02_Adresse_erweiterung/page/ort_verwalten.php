<?php
if(isset($_POST['delete']))
{
    try
    {
        $myArray = $_POST['myArray'];
        $myQuery1 = 'update plz 
                     set ort_id = null
                     where plz_id = (?)';
        $stmt1 = $con->prepare($myQuery1);
        for($i = 0; $i < sizeof($myArray); $i++)
        {
            $myArrayVal = $myArray[$i];
            if(isset($myArray[$i]))
            {
                $stmt1->execute([$myArrayVal]);
                echo "Ort wurde gelöscht plz_id: "."$myArrayVal";
            }
        }
    }
    catch (Exception $e)
    {
        echo $e->getCode().': '.$e->getMessage();
    }
}
else if(isset($_POST['change']))
{
    try
    {
        $changeOrt = $_POST['ort'];
        $myArray = $_POST['myArray'];
        $myQuery1 = 'update ort set ort_name = ? where ort_id = ?';
        $stmt1 = $con->prepare($myQuery1);
        $myQuery2 = 'select ort_id from ort where ort_id = (select ort_id from plz where plz_id = ?)';
        $stmt2 = $con->prepare($myQuery2);
        for($i = 0; $i < sizeof($myArray); $i++)
        {
            $myArrayVal = $myArray[$i];
            if(isset($myArray[$i]))
            {
                $stmt2->execute([$myArrayVal]);
                $myOrtId = $stmt2->fetch(PDO::FETCH_NUM);
                echo "MyOrtid: ".$myOrtId[0]."<br>";
                $stmt1->execute([$changeOrt, $myOrtId[0]]);
                echo "Ort wurde auf: ".$changeOrt." geändert plz_id: "."$myArrayVal";
            }
        }
    }
    catch (Exception $e)
    {
        echo $e->getCode().': '.$e->getMessage();
    }
}
else
{
    ?>
    <form method="post">
        <h3>Ortsname ändern oder löschen</h3>
        <br>
        <label for="ort">Ortsname ändern:</label>
        <input type="text" id="ort" name="ort">
        <br>
        <?php
        $query = 'select plz_id, concat(plz_nr, "   " , ort_name) "PLZ + Ort" from plz natural join ort
                      order by plz_nr, ort_name';
        makeTable2($query);
        ?>
        <input type="submit" name="delete" value="löschen">
        <input type="submit" name="change" value="ändern">
    </form>
    <?php
}
